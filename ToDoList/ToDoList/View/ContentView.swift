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

    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach($tasks.todos) { $todo in
                        HStack {
                            Text(todo.title)
                            Spacer()
                            Toggle("", isOn: $todo.isDone)
                                .labelsHidden()
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                }
            }.navigationTitle("ToDos")
        }.searchable(text: $searchText, prompt: "Search")
            .task {
                do {
                    try await tasks.fetchTodos()
                } catch {
                    print("Failed to load todos: \(error)")
                }
            }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
