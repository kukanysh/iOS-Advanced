//
//  ContentView.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 05.08.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchText: String = ""
    
    @StateObject var tasks = ToDoInteractor()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach($tasks.todos) { todo in
                        HStack {
                            Text(todo.title)
                            Toggle("", isOn: todo.isDone)
                        }
                    }
                }
            }.navigationTitle("ToDos")
        }.searchable(text: $searchText, prompt: "Search")
            .task {
                do {
                    try await tasks.fetchTodos()
                } catch {
                    print("Failed to load tasks: \(error)")
                }
            }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
