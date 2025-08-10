//
//  ContentView.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 05.08.2025.
//

import SwiftUI

protocol ToDoViewProtocol {
    var presenter: ToDoPresenterProtocol? { get set }
    func updateTodos(_ todos: [ToDoEntity])
}

struct ContentView: View, ToDoViewProtocol {
    var presenter: ToDoPresenterProtocol?
    @ObservedObject private var interactor: ToDoInteractor

    @State private var searchText: String = ""
    @State private var navigateToDetail = false
    @State private var selectedTask: ToDoEntity? = nil
    @State private var showAddTask = false

    init(presenter: ToDoPresenterProtocol?, interactor: ToDoInteractor) {
        self.presenter = presenter
        self.interactor = interactor
        // wire view ref back to presenter
        presenter?.view = self
    }

    func updateTodos(_ todos: [ToDoEntity]) {
        DispatchQueue.main.async {
            self.interactor.todos = todos
        }
    }

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(interactor.todos, id: \.id) { todo in
                        taskCard(todo: todo)
                    }
                }
                .padding(.bottom, 80)
            }
            .navigationTitle("ToDos")
            .navigationDestination(isPresented: $navigateToDetail) {
                if let selectedTask {
                    ToDoDetailView(task: selectedTask, presenter: presenter)
                }
            }
            .sheet(isPresented: $showAddTask) {
                AddTaskView(presenter: presenter)
            }
        }
        .tint(.yellow)
        .searchable(text: $searchText, prompt: "Search")
        .onChange(of: searchText) { value in
            presenter?.search(query: value)
        }
        .safeAreaInset(edge: .bottom) {
            bottomBar
        }
        .ignoresSafeArea()
        .task {
            await loadTodos()
        }
    }

    private var bottomBar: some View {
        ZStack {
            Color(.secondarySystemBackground)
            Text("\(interactor.todos.count) Task\(interactor.todos.count == 1 ? "" : "s")")
                .font(.callout)
                .foregroundStyle(.primary)
                .padding(.bottom, 20)
            HStack {
                Spacer()
                Button {
                    showAddTask = true
                } label: {
                    Image(systemName: "square.and.pencil")
                        .font(.title2)
                        .foregroundColor(.yellow)
                }
                .padding(.trailing, 23)
            }
            .padding(.bottom, 20)
        }
        .frame(height: 100)
    }

    @ViewBuilder
    private func taskCard(todo: ToDoEntity) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 12) {
                Button(action: {
                    presenter?.toggleCompletion(for: todo)
                }) {
                    Image(systemName: todo.completed ? "checkmark.circle" : "circle")
                        .font(.title)
                        .foregroundColor(todo.completed ? .yellow : .gray)
                }
                .buttonStyle(.plain)

                VStack(alignment: .leading, spacing: 10) {
                    Text(todo.todo)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .strikethrough(todo.completed, color: .gray)
                        .foregroundStyle(todo.completed ? .gray : .primary)

                    Text("User ID: \(todo.userId)")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                .contextMenu {
                    Button {
                        selectedTask = todo
                        navigateToDetail = true
                    } label: {
                        Label("Edit", systemImage: "pencil")
                    }
                    Button {
                        // share logic placeholder
                    } label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                    Button(role: .destructive) {
                        presenter?.deleteTodo(id: todo.id)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .padding(.horizontal, 10)

            Rectangle()
                .frame(height: 0.3)
                .foregroundColor(.gray)
                .padding(.horizontal, 16)
        }
    }

    private func loadTodos() async {
        guard let presenter = presenter else { return }
        do {
            let todos = try await presenter.fetchTodos()
            presenter.view?.updateTodos(todos)
        } catch {
            print("Error loading todos: \(error)")
        }
    }
}

// MARK: - Preview
#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let interactor = ToDoInteractor()
        let presenter = ToDoPresenter()
        presenter.interactor = interactor
        interactor.presenter = presenter
        presenter.view = nil
        let view = ContentView(presenter: presenter, interactor: interactor)
        presenter.view = view
        return view.preferredColorScheme(.dark)
    }
}
#endif
