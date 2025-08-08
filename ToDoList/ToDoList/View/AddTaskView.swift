//
//  AddTaskView.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 08.08.2025.
//

import SwiftUI

struct AddTaskView: View {
    
    @State private var taskTitle: String = ""
    @State private var isCompleted: Bool = false
    @State private var userId: Int = 1
    
    @Environment(\.dismiss) private var dismiss
    
    // Presenter reference for VIPER architecture
    var presenter: ToDoPresenterProtocol?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Task Title Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Task Title")
                            .font(.headline)
                            .foregroundStyle(.primary)
                        
                        TextField("Enter task description", text: $taskTitle, axis: .vertical)
                            .font(.body)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .lineLimit(3...6)
                    }
                    
                    // Status Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Initial Status")
                            .font(.headline)
                            .foregroundStyle(.primary)
                        
                        HStack {
                            Button(action: {
                                isCompleted.toggle()
                            }) {
                                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                                    .font(.title2)
                                    .foregroundColor(isCompleted ? .yellow : .gray)
                            }
                            .buttonStyle(.plain)
                            
                            Text(isCompleted ? "Completed" : "Not Completed")
                                .font(.callout)
                                .foregroundStyle(isCompleted ? .green : .orange)
                            
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    
                    // User ID Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("User ID")
                            .font(.headline)
                            .foregroundStyle(.primary)
                        
                        HStack {
                            TextField("User ID", value: $userId, format: .number)
                                .keyboardType(.numberPad)
                                .font(.callout)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            
                            Spacer()
                        }
                    }
                    
                    Spacer()
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.red)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveTask()
                    }
                    .fontWeight(.semibold)
                    .foregroundColor(.yellow)
                    .disabled(taskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
    
    private func saveTask() {
        let trimmedTitle = taskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedTitle.isEmpty else { return }
        
        // Generate a new ID (you might want to implement a better ID generation strategy)
        let newId = Int.random(in: 10...999)
        
        let newTask = ToDoEntity(
            id: newId,
            todo: trimmedTitle,
            completed: isCompleted,
            userId: userId
        )
        
        // Add through the presenter/interactor
        presenter?.interactor?.addTodo(newTask)
        
        print("New task created: \(trimmedTitle)")
        dismiss()
    }
}

#Preview {
    AddTaskView()
        .preferredColorScheme(.dark)
}
