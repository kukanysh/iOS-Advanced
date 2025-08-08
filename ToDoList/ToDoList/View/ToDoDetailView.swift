//
//  ToDoDetailView.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 07.08.2025.
//

import SwiftUI

struct ToDoDetailView: View {
    
    @State private var editedTask: ToDoEntity
    @State private var isEditing: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var presenter: ToDoPresenterProtocol?
    
    init(tasks: ToDoEntity, presenter: ToDoPresenterProtocol? = nil) {
        self._editedTask = State(initialValue: tasks)
        self.presenter = presenter
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Title section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Task")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    if isEditing {
                        TextField("Task title", text: $editedTask.todo, axis: .vertical)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .textFieldStyle(.plain)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    } else {
                        Text(editedTask.todo)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                }
                
                // Status section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Status")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    HStack {
                        Button(action: {
                            editedTask.completed.toggle()
                        }) {
                            Image(systemName: editedTask.completed ? "checkmark.circle.fill" : "circle")
                                .font(.title2)
                                .foregroundColor(editedTask.completed ? .yellow : .gray)
                        }
                        .buttonStyle(.plain)
                        
                        Text(editedTask.completed ? "Completed" : "Not Completed")
                            .font(.callout)
                            .foregroundStyle(editedTask.completed ? .green : .orange)
                    }
                }
                
                // User ID section
                VStack(alignment: .leading, spacing: 8) {
                    Text("User ID")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                    
                    Text("\(editedTask.userId)")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
        }
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Save" : "Edit") {
                    if isEditing {
                        saveChanges()
                    }
                    isEditing.toggle()
                }
                .fontWeight(.semibold)
                .foregroundColor(.yellow)
            }
        }
        .navigationBarBackButtonHidden(isEditing)
        .toolbar {
            if isEditing {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        cancelEditing()
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }
    
    private func saveChanges() {
        // Update through the presenter/interactor
        presenter?.interactor?.editTodo(editedTask)
        
        // You might want to add a success notification here
        print("Task updated: \(editedTask.todo)")
    }
    
    private func cancelEditing() {
        // Reset to original state if needed
        // You might want to keep the original task reference to reset to
        isEditing = false
    }
}

#Preview {
    ToDoDetailView(tasks: ToDoEntity(id: 1, todo: "fddf", completed: false, userId: 23))
        .preferredColorScheme(.dark)
}
