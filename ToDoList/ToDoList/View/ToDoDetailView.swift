//
//  ToDoDetailView.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 07.08.2025.
//

import SwiftUI

struct ToDoDetailView: View {
    
    let todo: ToDoEntity
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(todo.task)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Completed: \(todo.task)")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                
                
                Text("\(todo.userId)")
                
                
                Spacer()
                
                
            }.padding(.horizontal, 20)
                .padding(.top, 20)
        }
    }
}

#Preview {
    ToDoDetailView(todo: ToDoEntity(id: UUID(), task: "Finish all of the tasks", completed: false, userId: 2))
        .preferredColorScheme(.dark)
}
