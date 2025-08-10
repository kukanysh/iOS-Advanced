//
//  ToDoPresenter.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 06.08.2025.
//

import Foundation

protocol ToDoPresenterProtocol: AnyObject {
    var router: ToDoRouterProtocol? { get set }
    var interactor: ToDoInteractorProtocol? { get set }
    var view: ToDoViewProtocol? { get set }

    // fetch returns todos (bridge to interactor)
    func fetchTodos() async throws -> [ToDoEntity]

    // actions
    func addTodo(_ todo: ToDoEntity)
    func editTodo(_ todo: ToDoEntity)
    func deleteTodo(id: Int)
    func toggleCompletion(for todo: ToDoEntity)
    func search(query: String)
    func fetchTodosFromCoreData()
    func didSelectTodo(_ todo: ToDoEntity)
}

final class ToDoPresenter: ToDoPresenterProtocol {
    var router: ToDoRouterProtocol?
    var interactor: ToDoInteractorProtocol?
    var view: ToDoViewProtocol?

    func fetchTodos() async throws -> [ToDoEntity] {
        guard let interactor = interactor else { return [] }
        let todos = try await interactor.fetchTodos()
        // ensure view updated on main
        DispatchQueue.main.async {
            self.view?.updateTodos(todos)
        }
        return todos
    }

    func addTodo(_ todo: ToDoEntity) {
        interactor?.addTodo(todo)
    }

    func editTodo(_ todo: ToDoEntity) {
        interactor?.editTodo(todo)
    }

    func deleteTodo(id: Int) {
        interactor?.deleteTodo(id: id)
    }

    func toggleCompletion(for todo: ToDoEntity) {
        interactor?.toggleCompletion(for: todo)
    }

    func search(query: String) {
        interactor?.searchTodo(query: query)
    }

    func fetchTodosFromCoreData() {
        interactor?.fetchTodosFromCoreData()
    }

    func didSelectTodo(_ todo: ToDoEntity) {
        router?.navigateToDetailView(todo: todo)
    }
}
