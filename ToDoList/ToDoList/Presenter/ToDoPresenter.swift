//
//  ToDoPresenter.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 06.08.2025.
//

import Foundation

protocol ToDoPresenterProtocol {
    
    var router: ToDoRouterProtocol? { get set }
    var interactor: ToDoInteractorProtocol? { get set}
    var view: ToDoViewProtocol? { get set }
    
    func fetch()
    func didSelectTodo(_ todo: ToDoEntity)
    
}

class ToDoPresenter: ObservableObject, ToDoPresenterProtocol {
        
    var router: ToDoRouterProtocol?
    var interactor: ToDoInteractorProtocol?
    var view: ToDoViewProtocol?
    
    @Published var todos: [ToDoEntity] = []
    
    func fetch() {
        Task {
            do {
                if let todos = try await interactor?.fetchTodos() {
                    view?.updateTodos(todos)
                }
            } catch {
                print("Failed to fetch todos: \(error)")
            }
        }
    }
    
    func didSelectTodo(_ todo: ToDoEntity) {
        router?.navigateToDetailView(todo: todo)
        interactor?.toggleCompletion(for: todo)
    }
    
    
    
}
