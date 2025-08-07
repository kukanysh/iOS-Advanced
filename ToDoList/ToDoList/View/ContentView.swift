//
//  ContentView.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 05.08.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchText: String = ""
    
    @StateObject private var tasks = ToDoInteractor()
    
    @State private var selectedItemID: Int? = nil
    
    @State private var navigateToDetail = false

    
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(tasks.todos.indices, id: \.self) { index in
                        let todo = tasks.todos[index]
                        
                        VStack(spacing: 16) {
                            HStack(spacing: 12) {
                                Button(action: {
                                    tasks.todos[index].completed.toggle()
                                }) {
                                    Image(systemName: todo.completed ? "checkmark.circle" : "circle")
                                        .font(.title)
                                        .foregroundColor(todo.completed ? .yellow : .gray)
                                }
                                .buttonStyle(.plain)
                                .padding(.bottom, 60)
                                
                                HStack {
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(todo.task)
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .strikethrough(todo.completed, color: .gray)
                                            .foregroundStyle(todo.completed ? .gray : .primary)
                                        
                                        Text(todo.task)
                                            .font(.callout)
                                            .lineLimit(2)
                                            .fontWeight(.medium)
                                            .foregroundStyle(todo.completed ? .gray : .primary)
                                        
                                        
                                        Text("\(todo.userId)")
                                            .font(.callout)
                                            .foregroundStyle(.secondary)
                                    }
                                    .padding(.vertical, selectedItemID == index ? 16 : 0)
                                    .padding(.horizontal, selectedItemID == index ? 8 : 0)
                                    .background(
                                        selectedItemID == index ? Color.gray.opacity(0.4) : Color.clear,

                                    ).cornerRadius(16)
                                        
                                }
                                    
                                .contextMenu {
                                    Button {
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
                                        // delete logic here
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
                }.padding(.bottom, 80)
            }.navigationTitle("ToDos")
                
            .navigationDestination(isPresented: $navigateToDetail) {
                ToDoDetailView(todo: ToDoEntity(id: UUID(), task: "Finish all of the tasks", completed: false, userId: 2))
            }
            
        }.tint(.yellow)
        .searchable(text: $searchText, prompt: "Search")
            .task {
                do {
                    try await tasks.fetchTodos()
                } catch {
                    print("Failed to load todos: \(error)")
                }
            }
            .safeAreaInset(edge: .bottom) {
                ZStack {
                       // Background
                    Color(.secondarySystemBackground)

                       // Centered text
                       Text("7 Tasks")
                           .font(.callout)
                           .foregroundStyle(.primary)
                           .padding(.bottom, 20)

                       // Right button
                       HStack {
                           Spacer()
                           Button {
                               // Action
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
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
