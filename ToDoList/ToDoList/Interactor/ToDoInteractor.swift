//
//  ToDoInteractor.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 06.08.2025.
//

import Foundation


protocol ToDo {
    func fetchTodos() async throws -> [ToDoEntity]
    func addTodo(_ todo: ToDoEntity)
    func editTodo(_ todo: ToDoEntity)
    func deleteTodo(id: UUID)
}

<<<<<<< HEAD



class ToDoInteractor: ObservableObject, ToDo {
=======
class ToDoInteractor: ObservableObject, ToDo {

    
>>>>>>> feature/todo-router
    
    
    
    @Published var todos: [ToDoEntity]
    
    init() {
        
        self.todos = []
        
        Task {
            do {
                let loadedTodos = try await fetchTodos()
                DispatchQueue.main.async {
                    self.todos = loadedTodos
                }
            } catch {
                print("Init fetch error: \(error)")
            }
        }
    }

    
    //MARK: - Loading the data
    
    func fetchTodos() async throws -> [ToDoEntity] {
        guard let url = Bundle.main.url(forResource: "todos", withExtension: "json") else {
            throw ToDoError.wrongJsonFile
        }
        
        let data = try Data(contentsOf: url)
        let decoded = try JSONDecoder().decode(TodoResponse.self, from: data)
        return decoded.todos
    }
    
    
    func addTodo(_ todo: ToDoEntity) {
        todos.append(todo)
    }
    
<<<<<<< HEAD
    
    //MARK: - Editing the todos
    
    func editTodo(_ todo: ToDoEntity) {
        
    }
    
    
    //MARK: - Deleting the todos
    
=======
    func editTodo(_ todo: ToDoEntity) {
        <#code#>
    }
    
>>>>>>> feature/todo-router
    func deleteTodo(id: UUID) {
        todos.removeAll { $0.id == id }
    }
}

//MARK: - Error cases

enum ToDoError: Error {
    case wrongJsonFile
    case somethingWentWrong
}
