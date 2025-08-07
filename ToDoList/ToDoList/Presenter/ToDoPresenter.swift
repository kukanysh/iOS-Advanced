//
//  ToDoPresenter.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 06.08.2025.
//

import Foundation

protocol ToDoPresenterProtocol {
    func didFetchTodos(_ todos: [ToDoEntity])
    func didSelectTodo(_ todo: ToDoEntity)
}

final class ToDoPresenter: ObservableObject, ToDoPresenterProtocol {
    func didFetchTodos(_ todos: [ToDoEntity]) {
        <#code#>
    }
    
    func didSelectTodo(_ todo: ToDoEntity) {
        <#code#>
    }
    
    
}
