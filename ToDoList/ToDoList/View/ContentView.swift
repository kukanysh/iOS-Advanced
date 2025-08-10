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
    let isFromAPI: Bool
    
    
    
    init(presenter: ToDoPresenterProtocol? = nil, interactor: ToDoInteractor, isFromAPI: Bool = false) {
        var presenter = presenter ?? ToDoPresenter()
        self.presenter = presenter
        self.interactor = interactor
        self.isFromAPI = isFromAPI
        
        // Set up bidirectional relationships
        presenter.interactor = interactor
        interactor.presenter = presenter as? ToDoPresenter
        presenter.view = self
        
    }
    
    
    
    func updateTodos(_ todos: [ToDoEntity]) {
        DispatchQueue.main.async {
            self.interactor.todos = todos
        }
    }
    
    @State private var searchText: String = ""
    
    @State private var selectedTask: ToDoEntity? = nil
    
    @State private var navigationPath = NavigationPath()
    
    private var filteredTodos: [ToDoEntity] {
        if searchText.isEmpty {
            return interactor.todos
        } else {
            return interactor.todos.filter {
                $0.todo.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    //@State private var contextMenuActive = false

    
    var body: some View {
        
        //MARK: - Navigation Stack
        
        NavigationStack(path: $navigationPath) {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(filteredTodos, id: \.self) { todo in
                        taskCard(todo: todo)
                    }
                }.padding(.bottom, 80)
            }.navigationTitle("ToDos")
                .navigationDestination(for: ToDoEntity.self) { task in
                    ToDoDetailView(
                        tasks: task,
                        presenter: presenter,
                        startEditing: true
                    )
                }
                .navigationDestination(for: String.self) { route in
                    if route == "addNewTask" {
                        ToDoDetailView(
                            tasks: ToDoEntity(id: 0, todo: "", completed: false, userId: 1),
                            presenter: presenter,
                            isNewTask: true
                        )
                    }
                }
            
        }.tint(.yellow)
        .searchable(text: $searchText, prompt: "Search")
        .safeAreaInset(edge: .bottom) {
            
            //MARK: - Bottom bar
            
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
                            navigationPath.append("addNewTask")
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
                do {
                    await presenter?.fetch()
                } catch {
                    // Show an alert or error message to the user
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
}


//MARK: - View extension card

extension ContentView {
    @ViewBuilder
    private func taskCard(todo: ToDoEntity) -> some View {
        
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 12) {
                Button(action: {
                    presenter?.didSelectTodo(todo)
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
                        
                        if !isFromAPI || todo.taskDescription?.isEmpty == false {
                            Text(todo.taskDescription ?? todo.todo)
                                .font(.callout)
                                .lineLimit(2)
                                .foregroundStyle(.secondary)
                                .foregroundStyle(todo.completed ? .gray : .primary)
                        }
                            
                        
                        
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
                        navigationPath.append(todo)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            selectedTask = todo
                        }
                        
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
//                .onAppear { contextMenuActive = true }
//                .onDisappear { contextMenuActive = false }
//                .background(contextMenuActive ? Color.gray.opacity(0.4) : Color.clear)
//                .padding(.horizontal, contextMenuActive ? 8 : 0)
//                .padding(.vertical, contextMenuActive ? 16 : 0)
                
                //Tried to edit the background but could not
                
            }.padding(.horizontal, 10)
            
            
            
            Rectangle()
                .frame(height: 0.3)
                .foregroundColor(.gray)
                .padding(.horizontal, 16)
        }
    }
}


//MARK: - Preview

#Preview {
    let interactor = ToDoInteractor()
    // Add some test data
    interactor.todos = [
        ToDoEntity(id: 1, todo: "Test task 1", completed: false, userId: 1),
        ToDoEntity(id: 2, todo: "Test task 2", completed: true, userId: 1)
    ]
    
    let presenter = ToDoPresenter()
    presenter.interactor = interactor
    
    return ContentView(presenter: presenter, interactor: interactor)
        .preferredColorScheme(.dark)
}
