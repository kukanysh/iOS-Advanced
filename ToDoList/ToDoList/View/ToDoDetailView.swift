//
//  ToDoDetailView.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 07.08.2025.
//

import SwiftUI

struct ToDoDetailView: View {
    var task: ToDoEntity
    var presenter: ToDoPresenterProtocol?

    @State private var title: String
    @State private var userIdText: String
    @State private var completed: Bool
    @Environment(\.dismiss) private var dismiss

    init(task: ToDoEntity, presenter: ToDoPresenterProtocol?) {
        self.task = task
        self.presenter = presenter
        _title = State(initialValue: task.todo)
        _userIdText = State(initialValue: String(task.userId))
        _completed = State(initialValue: task.completed)
    }

    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("User ID", text: $userIdText)
                .keyboardType(.numberPad)
            Toggle("Completed", isOn: $completed)
        }
        .navigationTitle("Edit Task")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    guard let uid = Int(userIdText) else { return }
                    let edited = ToDoEntity(
                        id: task.id,
                        todo: title,
                        completed: completed,
                        userId: uid
                    )
                    presenter?.editTodo(edited)
                    dismiss()
                }
            }
        }
    }
}

// MARK: - Preview

#if DEBUG
private final class MockPresenter: ToDoPresenterProtocol {
    var router: ToDoRouterProtocol?
    var interactor: ToDoInteractorProtocol?
    var view: ToDoViewProtocol?

    func fetchTodos() async throws -> [ToDoEntity] { [] }
    func addTodo(_ todo: ToDoEntity) { }
    func editTodo(_ todo: ToDoEntity) { print("Mock edit called: \(todo)") }
    func deleteTodo(id: Int) { }
    func toggleCompletion(for todo: ToDoEntity) { }
    func search(query: String) { }
    func fetchTodosFromCoreData() { }
    func didSelectTodo(_ todo: ToDoEntity) { }
}

struct ToDoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let mock = MockPresenter()
        let sample = ToDoEntity(id: 1, todo: "Sample task", completed: false, userId: 42)
        return NavigationView {
            ToDoDetailView(task: sample, presenter: mock)
        }
        .preferredColorScheme(.dark)
    }
}
#endif
