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
    
    
    
    @Published var todos: [ToDoEntity]
    
    init() {
        self.todos = []
        
        // Try loading on init (optional, or keep this in .task in View)
        Task {
            do {
                let loadedTodos = try await fetchTodos()
                print(loadedTodos)
            } catch {
                print("Init fetch error: \(error)")
            }
        }
    }

    
    //MARK: - Loading the data
    
    func fetchTodos() async throws -> [ToDoEntity] {
        
        guard let url = Bundle.main.url(forResource: "todos", withExtension: "json") else {
            print("todos.json not found")
            
            throw ToDoError.wrongJsonFile
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(TodoResponse.self, from: data)
            
            DispatchQueue.main.async {
                self.todos = decoded.todos
            }
            
            return decoded.todos
            
        } catch {
            print("Failed to decode JSON: \(error)")
            throw ToDoError.somethingWentWrong
        }
        
    }
    
    //MARK: - Adding the todos
    
    func addTodo(_ todo: ToDoEntity) {
        todos.append(todo)
    }
    
    
    //MARK: - Editing the todos
    
    func editTodo(_ todo: ToDoEntity) {
        
    }
    
    
    //MARK: - Deleting the todos
    
    func deleteTodo(id: UUID) {
        
    }
        
    
    
}

//MARK: - Error cases

enum ToDoError: Error {
    case wrongJsonFile
    case somethingWentWrong
}
