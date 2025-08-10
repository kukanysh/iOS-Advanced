//
//  ToDoInteractor.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 06.08.2025.
//

import Foundation
import CoreData


//MARK: - Protocol

protocol ToDoInteractorProtocol {
    var presenter: ToDoPresenter? { get set }
    
    func fetchTodos() async throws -> [ToDoEntity]
    func addTodo(_ todo: ToDoEntity)
    func editTodo(_ todo: ToDoEntity)
    func deleteTodo(id: Int)
    func toggleCompletion(for todo: ToDoEntity)
    
    var todos: [ToDoEntity] { get set }
}

class ToDoInteractor: ObservableObject, ToDoInteractorProtocol {
    
    var presenter: ToDoPresenter?
    
    @Published var todos: [ToDoEntity] = []
    
    // Core Data Manager
    private let coreDataManager = CoreDataManager.shared
    
    // MARK: - Loading the data from Core Data
    func fetchTodos() async throws -> [ToDoEntity] {
        return try await withCheckedThrowingContinuation { continuation in
            let context = coreDataManager.backgroundContext
            
            context.perform {
                do {
                    let request = NSFetchRequest<NSManagedObject>(entityName: "ToDoModel")
                    
                    let coreDataTodos = try context.fetch(request)
                    print("Fetched \(coreDataTodos.count) todos from Core Data") // Debug print
                    
                    let fetchedTodos = coreDataTodos.map { coreDataModel in
                        ToDoEntity(
                            id: Int(coreDataModel.value(forKey: "id") as? Int64 ?? 0),
                            todo: coreDataModel.value(forKey: "todo") as? String ?? "",
                            completed: coreDataModel.value(forKey: "completed") as? Bool ?? false,
                            userId: Int(coreDataModel.value(forKey: "userId") as? Int64 ?? 0)
                        )
                    }
                    
                    DispatchQueue.main.async {
                        self.todos = fetchedTodos
                        continuation.resume(returning: fetchedTodos)
                    }
                    
                } catch {
                    print("Fetch error: \(error)") // Debug print
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    // MARK: - Adding todos
    func addTodo(_ todo: ToDoEntity) {
        print("Adding todo: \(todo.todo)")
        
        let context = coreDataManager.backgroundContext
        
        context.perform {
            let model = NSEntityDescription.insertNewObject(forEntityName: "ToDoModel", into: context)
            model.setValue(Int64(todo.id), forKey: "id")
            model.setValue(todo.todo, forKey: "todo")
            model.setValue(todo.completed, forKey: "completed")
            model.setValue(Int64(todo.userId), forKey: "userId")
            
            do {
                try context.save()
                
                DispatchQueue.main.async {
                    self.todos.append(todo)
                    self.presenter?.view?.updateTodos(self.todos)
                    print("Added new todo. Total count: \(self.todos.count)")
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error adding todo: \(error)")
                }
            }
        }
    }
    
    // MARK: - Editing the todos
    func editTodo(_ todo: ToDoEntity) {
        print("Editing todo: \(todo.todo)")
        
        let context = coreDataManager.backgroundContext
        
        context.perform {
            let request = NSFetchRequest<NSManagedObject>(entityName: "ToDoModel")
            request.predicate = NSPredicate(format: "id == %d", todo.id)
            
            do {
                let results = try context.fetch(request)
                guard let model = results.first else {
                    print("Todo not found")
                    return
                }
                
                model.setValue(todo.todo, forKey: "todo")
                model.setValue(todo.completed, forKey: "completed")
                model.setValue(Int64(todo.userId), forKey: "userId")
                
                try context.save()
                
                DispatchQueue.main.async {
                    if let index = self.todos.firstIndex(where: { $0.id == todo.id }) {
                        self.todos[index] = todo
                        self.presenter?.view?.updateTodos(self.todos)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error editing todo: \(error)")
                }
            }
        }
    }
    
    // MARK: - Deleting the todos
    func deleteTodo(id: Int) {
        let beforeCount = todos.count
        print("Deleting todo with id: \(id)")
        
        let context = coreDataManager.backgroundContext
        
        context.perform {
            let request = NSFetchRequest<NSManagedObject>(entityName: "ToDoModel")
            request.predicate = NSPredicate(format: "id == %d", id)
            
            do {
                let results = try context.fetch(request)
                guard let model = results.first else {
                    print("Todo not found")
                    return
                }
                
                context.delete(model)
                try context.save()
                
                DispatchQueue.main.async {
                    self.todos.removeAll { $0.id == id }
                    let afterCount = self.todos.count
                    
                    self.presenter?.view?.updateTodos(self.todos)
                    print("Deleted todo with id: \(id). Before: \(beforeCount), After: \(afterCount)")
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error deleting todo: \(error)")
                }
            }
        }
    }
    
    // MARK: - Toggle completion
    func toggleCompletion(for todo: ToDoEntity) {
        print("Toggling completion for todo: \(todo.todo)")
        
        let context = coreDataManager.backgroundContext
        
        context.perform {
            let request = NSFetchRequest<NSManagedObject>(entityName: "ToDoModel")
            request.predicate = NSPredicate(format: "id == %d", todo.id)
            
            do {
                let results = try context.fetch(request)
                guard let model = results.first else {
                    print("Todo not found")
                    return
                }
                
                let currentCompleted = model.value(forKey: "completed") as? Bool ?? false
                model.setValue(!currentCompleted, forKey: "completed")
                try context.save()
                
                DispatchQueue.main.async {
                    if let index = self.todos.firstIndex(where: { $0.id == todo.id }) {
                        self.todos[index].completed = !currentCompleted
                        self.presenter?.view?.updateTodos(self.todos)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error toggling completion: \(error)")
                }
            }
        }
    }
    
    // MARK: - Search functionality
    func searchTodos(query: String) {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            Task {
                do {
                    _ = try await fetchTodos()
                } catch {
                    print("Error fetching all todos: \(error)")
                }
            }
            return
        }
        
        let context = coreDataManager.backgroundContext
        
        context.perform {
            let request = NSFetchRequest<NSManagedObject>(entityName: "ToDoModel")
            request.predicate = NSPredicate(format: "todo CONTAINS[cd] %@", query)
            request.sortDescriptors = [
                NSSortDescriptor(key: "completed", ascending: true),
                NSSortDescriptor(key: "id", ascending: false)
            ]
            
            do {
                let coreDataTodos = try context.fetch(request)
                let filteredTodos = coreDataTodos.map { coreDataModel in
                    ToDoEntity(
                        id: Int(coreDataModel.value(forKey: "id") as? Int64 ?? 0),
                        todo: coreDataModel.value(forKey: "todo") as? String ?? "",
                        completed: coreDataModel.value(forKey: "completed") as? Bool ?? false,
                        userId: Int(coreDataModel.value(forKey: "userId") as? Int64 ?? 0)
                    )
                }
                
                DispatchQueue.main.async {
                    self.todos = filteredTodos
                    self.presenter?.view?.updateTodos(filteredTodos)
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error searching todos: \(error)")
                }
            }
        }
    }
    
    // MARK: - Initial data migration (if needed)
    func migrateFromJSONIfNeeded() async {
        let context = coreDataManager.mainContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "ToDoModel")
        
        do {
            let count = try context.count(for: request)
            if count == 0 {
                print("Core Data is empty, migrating from JSON...")
                await migrateFromJSON()
            }
        } catch {
            print("Error checking Core Data count: \(error)")
        }
    }
    
    private func migrateFromJSON() async {
        guard let url = Bundle.main.url(forResource: "todos", withExtension: "json") else {
            print("JSON file not found for migration")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(Response.self, from: data)
            
            for todoEntity in decoded.todos {
                addTodo(todoEntity)
            }
            
            print("Successfully migrated \(decoded.todos.count) todos from JSON to Core Data")
        } catch {
            print("Error migrating from JSON: \(error)")
        }
    }
    
    private struct Response: Codable {
        let todos: [ToDoEntity]
    }
}

// MARK: - Error cases
enum ToDoError: Error, LocalizedError {
    case wrongJsonFile
    case somethingWentWrong
}
