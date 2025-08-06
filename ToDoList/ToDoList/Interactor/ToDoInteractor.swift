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

class ToDoInteractor: ObservableObject, ToDo {

    
    
    @Published var todos: [ToDoEntity] = []

    
    //MARK: - Loading the data
    
    func fetchTodos() async throws -> [ToDoEntity] {
        
        guard let url = Bundle.main.url(forResource: "todos", withExtension: "json") else {
            print("todos.json not found")
            
            throw ToDoError.wrongJsonFile
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([ToDoEntity].self, from: data)
            DispatchQueue.main.async {
                self.todos = decoded
            }
            
            return decoded
            
        } catch {
            print("Failed to decode JSON: \(error)")
            throw ToDoError.somethingWentWrong
        }
        
    }
    
    
    func addTodo(_ todo: ToDoEntity) {
        todos.append(todo)
    }
    
    func editTodo(_ todo: ToDoEntity) {
        <#code#>
    }
    
    func deleteTodo(id: UUID) {
        todos.removeAll { $0.id == id }
    }
}

//MARK: - Error cases

enum ToDoError: Error {
    case wrongJsonFile
    case somethingWentWrong
}
