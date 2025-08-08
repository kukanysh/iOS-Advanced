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
    
    func fetch() async
    func didSelectTodo(_ todo: ToDoEntity)
    
}

class ToDoPresenter: ObservableObject, ToDoPresenterProtocol {
        
    var router: ToDoRouterProtocol?
    var interactor: ToDoInteractorProtocol?
    var view: ToDoViewProtocol?
    
    @Published var todos: [ToDoEntity] = []
    
    func fetch() async {
        Task {
            do {
                let fetchedTodos = try await interactor?.fetchTodos() ?? []
                interactor?.todos = fetchedTodos
                view?.updateTodos(fetchedTodos)
            } catch {
                print("Fetch failed: \(error)")
            }
        }
    }
    
    func didSelectTodo(_ todo: ToDoEntity) {
        router?.navigateToDetailView(todo: todo)
        interactor?.toggleCompletion(for: todo)
    }
    
    
    
}
