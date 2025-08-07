//
//  ToDoRouter.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 06.08.2025.
//

import Foundation

protocol ToDoRouterProtocol {
    func navigateToDetailView(for todo: ToDoEntity)
}


final class ToDoRouter: ToDoRouterProtocol {
    
    @Published var selectedToDo: ToDoEntity?
    
    func navigateToDetailView(for todo: ToDoEntity) {
        selectedToDo = todo
    }
    
    
}
