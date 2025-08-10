//
//  ToDoInteractor.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 06.08.2025.
//

import Foundation
import CoreData

private struct ToDoDTO: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int
}

private struct ResponseDTO: Codable {
    let todos: [ToDoDTO]
}

protocol ToDoInteractorProtocol {
    var presenter: ToDoPresenterProtocol? { get set }
    var todos: [ToDoEntity] { get set }

    // load initial (from CoreData if present, else from todos.json -> persist to CoreData)
    func fetchTodos() async throws -> [ToDoEntity]

    // CRUD
    func addTodo(_ todo: ToDoEntity)
    func editTodo(_ todo: ToDoEntity)
    func deleteTodo(id: Int)

    // search and raw fetch
    func searchTodo(query: String)
    func fetchTodosFromCoreData()

    // convenience
    func toggleCompletion(for todo: ToDoEntity)
}

final class ToDoInteractor: ObservableObject, ToDoInteractorProtocol {
    var presenter: ToDoPresenterProtocol?

    @Published var todos: [ToDoEntity] = []

    private let persistence = PersistenceController.shared
    // main-thread context (read-only access on main thread)
    private var viewContext: NSManagedObjectContext { persistence.container.viewContext }

    // MARK: - Helpers

    private func mapCommit(_ commit: Commit) -> ToDoEntity {
        ToDoEntity(
            id: Int(commit.id),
            todo: commit.todo ?? "",
            completed: commit.completed,
            userId: Int(commit.userId)
        )
    }

    // MARK: - Fetch (initial)
    // Replace your current fetchTodos() with this implementation (inside ToDoInteractor)
    func fetchTodos() async throws -> [ToDoEntity] {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                let request: NSFetchRequest<Commit> = Commit.fetchRequest()
                print("[Interactor] fetchTodos() started")

                // 1) Check Core Data quickly on main
                var existingOnMain: [Commit] = []
                self.viewContext.performAndWait {
                    do {
                        existingOnMain = try self.viewContext.fetch(request)
                        print("[Interactor] CoreData existing count (main): \(existingOnMain.count)")
                    } catch {
                        print("[Interactor] CoreData fetch error (main):", error)
                        existingOnMain = []
                    }
                }

                if !existingOnMain.isEmpty {
                    let mapped = existingOnMain.map { self.mapCommit($0) }
                    DispatchQueue.main.async {
                        self.todos = mapped
                        self.presenter?.view?.updateTodos(mapped)
                    }
                    continuation.resume(returning: mapped)
                    print("[Interactor] Returning existing CoreData items")
                    return
                }

                // 2) Not in CoreData -> load JSON
                guard let url = Bundle.main.url(forResource: "todos", withExtension: "json") else {
                    print("[Interactor] todos.json not found in bundle")
                    continuation.resume(throwing: ToDoError.wrongJsonFile)
                    return
                }

                do {
                    let data = try Data(contentsOf: url)
                    // Try decode two possible shapes:
                    var dtos: [ToDoDTO] = []

                    // First try object { "todos": [...] }
                    if let resp = try? JSONDecoder().decode(ResponseDTO.self, from: data) {
                        dtos = resp.todos
                        print("[Interactor] Decoded JSON as ResponseDTO, count: \(dtos.count)")
                    } else if let arr = try? JSONDecoder().decode([ToDoDTO].self, from: data) {
                        dtos = arr
                        print("[Interactor] Decoded JSON as plain array, count: \(dtos.count)")
                    } else {
                        print("[Interactor] JSON decode failed: wrong shape")
                        continuation.resume(throwing: ToDoError.wrongJsonFile)
                        return
                    }

                    // Persist to Core Data on background context
                    let bgContext = self.persistence.newBackgroundContext()
                    bgContext.perform {
                        for dto in dtos {
                            let commit = Commit(context: bgContext)
                            commit.id = Int64(dto.id)
                            commit.todo = dto.todo
                            commit.completed = dto.completed
                            commit.userId = Int64(dto.userId)
                        }
                        do {
                            try bgContext.save()
                            print("[Interactor] Saved \(dtos.count) items to CoreData (bgContext)")
                        } catch {
                            print("[Interactor] bgContext.save() failed:", error)
                            continuation.resume(throwing: error)
                            return
                        }

                        // Fetch from main viewContext to update UI
                        self.viewContext.performAndWait {
                            do {
                                let updated = try self.viewContext.fetch(request)
                                let mapped = updated.map { self.mapCommit($0) }
                                DispatchQueue.main.async {
                                    self.todos = mapped
                                    self.presenter?.view?.updateTodos(mapped)
                                }
                                continuation.resume(returning: mapped)
                                print("[Interactor] Fetched after save; returning \(mapped.count) items")
                            } catch {
                                print("[Interactor] viewContext fetch after save failed:", error)
                                continuation.resume(throwing: error)
                            }
                        }
                    }
                } catch {
                    print("[Interactor] Error reading JSON file:", error)
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    // Debug helper — call from .task { await interactor.debugDumpCoreData() }
    // to print saved commits and their values.
    func debugDumpCoreData() async {
        await withCheckedContinuation { cont in
            DispatchQueue.global(qos: .utility).async {
                let request: NSFetchRequest<Commit> = Commit.fetchRequest()
                self.viewContext.performAndWait {
                    do {
                        let results = try self.viewContext.fetch(request)
                        print("=== debugDumpCoreData: found \(results.count) commits ===")
                        for c in results {
                            print("Commit id:\(c.id) todo:'\(c.todo ?? "")' completed:\(c.completed) userId:\(c.userId)")
                        }
                    } catch {
                        print("debugDumpCoreData fetch error:", error)
                    }
                    cont.resume()
                }
            }
        }
    }


    // MARK: - Add
    func addTodo(_ todo: ToDoEntity) {
        DispatchQueue.global(qos: .userInitiated).async {
            let bgContext = self.persistence.newBackgroundContext()
            bgContext.perform {
                let commit = Commit(context: bgContext)
                // Use timestamp-based Int64 id to keep parity with your model
                commit.id = Int64(Date().timeIntervalSince1970 * 1000) // ms resolution
                commit.todo = todo.todo
                commit.completed = todo.completed
                commit.userId = Int64(todo.userId)

                do {
                    try bgContext.save()
                    // notify main thread to refresh
                    DispatchQueue.main.async {
                        self.fetchTodosFromCoreData()
                    }
                } catch {
                    print("Add Save error: \(error)")
                }
            }
        }
    }

    // MARK: - Edit
    func editTodo(_ todo: ToDoEntity) {
        DispatchQueue.global(qos: .userInitiated).async {
            let bgContext = self.persistence.newBackgroundContext()
            bgContext.perform {
                let request: NSFetchRequest<Commit> = Commit.fetchRequest()
                request.predicate = NSPredicate(format: "id == %d", todo.id)
                do {
                    if let found = try bgContext.fetch(request).first {
                        found.todo = todo.todo
                        found.completed = todo.completed
                        found.userId = Int64(todo.userId)
                        try bgContext.save()
                        DispatchQueue.main.async {
                            self.fetchTodosFromCoreData()
                        }
                    }
                } catch {
                    print("Edit error: \(error)")
                }
            }
        }
    }

    // MARK: - Delete
    func deleteTodo(id: Int) {
        DispatchQueue.global(qos: .userInitiated).async {
            let bgContext = self.persistence.newBackgroundContext()
            bgContext.perform {
                let request: NSFetchRequest<Commit> = Commit.fetchRequest()
                request.predicate = NSPredicate(format: "id == %d", id)
                do {
                    let results = try bgContext.fetch(request)
                    results.forEach { bgContext.delete($0) }
                    if bgContext.hasChanges {
                        try bgContext.save()
                    }
                    DispatchQueue.main.async {
                        self.fetchTodosFromCoreData()
                    }
                } catch {
                    print("Delete error: \(error)")
                }
            }
        }
    }

    // MARK: - Toggle completion
    func toggleCompletion(for todo: ToDoEntity) {
        var updated = todo
        updated.completed.toggle()
        editTodo(updated)
    }

    // MARK: - Search
    func searchTodo(query: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            let request: NSFetchRequest<Commit> = Commit.fetchRequest()
            if !query.isEmpty {
                request.predicate = NSPredicate(format: "todo CONTAINS[cd] %@", query)
            }
            self.viewContext.perform {
                do {
                    let results = try self.viewContext.fetch(request)
                    let mapped = results.map { self.mapCommit($0) }
                    DispatchQueue.main.async {
                        self.presenter?.view?.updateTodos(mapped)
                    }
                } catch {
                    print("Search fetch error: \(error)")
                }
            }
        }
    }

    // MARK: - Fetch raw from Core Data (used to refresh UI)
    func fetchTodosFromCoreData() {
        DispatchQueue.global(qos: .userInitiated).async {
            let request: NSFetchRequest<Commit> = Commit.fetchRequest()
            self.viewContext.perform {
                do {
                    let results = try self.viewContext.fetch(request)
                    let mapped = results.map { self.mapCommit($0) }
                    DispatchQueue.main.async {
                        self.todos = mapped
                        self.presenter?.view?.updateTodos(mapped)
                    }
                } catch {
                    print("Fetch error: \(error)")
                }
            }
        }
    }
}

// MARK: - Errors
enum ToDoError: Error {
    case wrongJsonFile
    case somethingWentWrong
}
