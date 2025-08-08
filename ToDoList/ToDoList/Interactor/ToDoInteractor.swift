//
//  ToDoInteractor.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 06.08.2025.
//

import Foundation


protocol ToDoInteractorProtocol {
    
    var presenter: ToDoPresenter? { get set }
    
    func fetchTodos() async throws -> [ToDoEntity]
    func addTodo(_ todo: ToDoEntity)
    func editTodo(_ todo: ToDoEntity)
    func deleteTodo(id: Int)
    
    func toggleCompletion(for todo: ToDoEntity)
}


class ToDoInteractor: ObservableObject, ToDoInteractorProtocol {
   
    var presenter: ToDoPresenter?
        
    @Published var todos: [ToDoEntity] = []

    
    //MARK: - Loading the data

    func fetchTodos() async throws -> [ToDoEntity] {
        guard let url = Bundle.main.url(forResource: "todos", withExtension: "json") else {
            print("JSON file not found")
            throw ToDoError.wrongJsonFile
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(Response.self, from: data)
            return decoded.todos
        } catch {
            print("Error decoding JSON: \(error)")
            throw error
        }
    }
    
    private struct Response: Codable {
        let todos: [ToDoEntity]
    }

    
    
    func addTodo(_ todo: ToDoEntity) {
        print("Adding todo: \(todo.todo)")
        todos.append(todo)
        
        // Ensure UI update happens on main thread immediately
        DispatchQueue.main.async {
            self.presenter?.view?.updateTodos(self.todos)
        }
        
        print("Added new todo. Total count: \(todos.count)")
    }
    
    //MARK: - Editing the todos

    func editTodo(_ todo: ToDoEntity) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index] = todo
            
            // Update UI on main thread
            DispatchQueue.main.async {
                self.presenter?.view?.updateTodos(self.todos)
            }
            
            print("Updated todo: \(todo.todo)")
        }
    }
    
    
    //MARK: - Deleting the todos
    
    func deleteTodo(id: Int) {
        let beforeCount = todos.count
        todos.removeAll { $0.id == id }
        let afterCount = todos.count
        
        print("Deleted todo with id: \(id). Before: \(beforeCount), After: \(afterCount)")
        
        // Update UI on main thread
        DispatchQueue.main.async {
            self.presenter?.view?.updateTodos(self.todos)
        }
    }
    
    func toggleCompletion(for todo: ToDoEntity) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].completed.toggle()
            presenter?.view?.updateTodos(todos)
        }
    }

}

//MARK: - Error cases

enum ToDoError: Error {
    case wrongJsonFile
    case somethingWentWrong
}
