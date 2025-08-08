//
//  ContentView.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 05.08.2025.
//

import SwiftUI

//MARK: - Protocol
protocol ToDoViewProtocol {
    var presenter: ToDoPresenterProtocol? { get set }
    func updateTodos(_ todos: [ToDoEntity])
}


//MARK: - View

struct ContentView: View, ToDoViewProtocol {
    
     var presenter: ToDoPresenterProtocol?
    @ObservedObject var interactor: ToDoInteractor
    
    
    init(presenter: ToDoPresenterProtocol?, interactor: ToDoInteractor) {
        self.presenter = presenter
        self.interactor = interactor
        if var localPresenter = presenter {
            localPresenter.view = self
        }
    }
    
    
    
    func updateTodos(_ todos: [ToDoEntity]) {
        DispatchQueue.main.async {
            self.interactor.todos = todos
        }
    }
    
    @State private var searchText: String = ""
    
    @State private var navigateToDetail = false
    
    @State private var selectedTask: ToDoEntity? = nil
    
    @State private var showAddTask = false
    
    private var filteredTodos: [ToDoEntity] {
        if searchText.isEmpty {
            return interactor.todos
        } else {
            return interactor.todos.filter {
                $0.todo.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(filteredTodos, id: \.self) { todo in
                        taskCard(todo: todo)
                    }
                }.padding(.bottom, 80)
            }.navigationTitle("ToDos")
                .navigationDestination(isPresented: $navigateToDetail) {
                    if let selectedTask {
                        ToDoDetailView(tasks: selectedTask, presenter: presenter)
                    }
                }
                .sheet(isPresented: $showAddTask) {
                    AddTaskView(presenter: presenter)
                }
            
        }.tint(.yellow)
        .searchable(text: $searchText, prompt: "Search")
        .safeAreaInset(edge: .bottom) {
            ZStack {
                    // Background
                Color(.secondarySystemBackground)

                    // Centered text
                Text("\(interactor.todos.count) Task\(interactor.todos.count == 1 ? "" : "s")")
                .font(.callout)
                .foregroundStyle(.primary)
                .padding(.bottom, 20)

                    // Right button
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
                        
                    }.padding(.bottom, 20)
                }
                .frame(height: 100)

            
        }.ignoresSafeArea()
            .task {
                await presenter?.fetch()
            }
    }
}



extension ContentView {
    @ViewBuilder
    private func taskCard(todo: ToDoEntity) -> some View {
        
        let todoItem = interactor.todos
        
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 12) {
                Button(action: {
                    if let index = interactor.todos.firstIndex(where: { $0.id == todo.id }) {
                        interactor.todos[index].completed.toggle()
                    }
                }) {
                    Image(systemName: todo.completed ? "checkmark.circle" : "circle")
                        .font(.title)
                        .foregroundColor(todo.completed ? .yellow : .gray)
                }
                .buttonStyle(.plain)
                
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(todo.todo)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .strikethrough(todo.completed, color: .gray)
                            .foregroundStyle(todo.completed ? .gray : .primary)
                        
                        Text(todo.todo)
                            .font(.callout)
                            .lineLimit(2)
                            .fontWeight(.medium)
                            .foregroundStyle(todo.completed ? .gray : .primary)
                        
                        
                        Text("\(todo.userId)")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
//                    .padding(.vertical, selectedItemID == index ? 16 : 0)
//                    .padding(.horizontal, selectedItemID == index ? 8 : 0)
//                    .background(
//                        selectedItemID == index ? Color.gray.opacity(0.4) : Color.clear
//                    ).cornerRadius(16)
                    
                }
                .contextMenu {
                    Button {
                        selectedTask = todo
                        navigateToDetail = true
                    } label: {
                        Label("Edit", image: "edit")
                    }
                    
                    Button {
                        // share logic here
                    } label: {
                        Label("Share", image: "export")
                        
                    }
                    
                    Button(role: .destructive) {
                        presenter?.interactor?.deleteTodo(id: todo.id)
                    } label: {
                        Label("Delete", image: "trash")
                    }
                }
                .onLongPressGesture {
                    
                }
                
            }.padding(.horizontal, 10)
            
            
            
            Rectangle()
                .frame(height: 0.3)
                .foregroundColor(.gray)
                .padding(.horizontal, 16)
        }
    }
}

#Preview {
    let interactor = ToDoInteractor()
    let presenter = ToDoPresenter()
    presenter.interactor = interactor
    let router = ToDoRouter()
    presenter.router = router

    return ContentView(presenter: presenter, interactor: interactor)
        .preferredColorScheme(.dark)
}
