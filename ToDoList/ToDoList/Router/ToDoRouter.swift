//
//  ToDoRouter.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 06.08.2025.
//
//
import Foundation
import SwiftUI

protocol ToDoRouterProtocol: AnyObject {
    func start() -> AnyView
    func navigateToDetailView(todo: ToDoEntity)
}

final class ToDoRouter: ObservableObject, ToDoRouterProtocol {
    @Published var selectedToDo: ToDoEntity? = nil
    @Published var isShowingDetail: Bool = false

    func start() -> AnyView {
        let presenter = ToDoPresenter()
        let interactor = ToDoInteractor()
        let view = ContentView(presenter: presenter, interactor: interactor)

        presenter.interactor = interactor
        presenter.router = self
        presenter.view = view
        interactor.presenter = presenter

        return AnyView(view)
    }

    func navigateToDetailView(todo: ToDoEntity) {
        selectedToDo = todo
        isShowingDetail = true
    }
}
