//
//  ContentView.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 05.08.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchText: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    
                }
            }.navigationTitle("ToDos")
        }.searchable(text: $searchText, prompt: "Search")
    }
}

#Preview {
    ContentView()
}
