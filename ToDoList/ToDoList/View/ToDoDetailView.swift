//
//  ToDoDetailView.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 07.08.2025.
//

import SwiftUI

//MARK: - View

struct ToDoDetailView: View {
    @State private var editedTask: ToDoEntity
    @State private var isEditing: Bool
    @State private var taskDescription: String
    @State private var creationDate: Date
    @Environment(\.dismiss) private var dismiss
    var presenter: ToDoPresenterProtocol?
    let isNewTask: Bool
    let isFromAPI: Bool
    
    init(
        tasks: ToDoEntity,
        presenter: ToDoPresenterProtocol? = nil,
        startEditing: Bool = false,
        isNewTask: Bool = false,
        isFromAPI: Bool = false
    ) {
        self._editedTask = State(initialValue: tasks)
        self._isEditing = State(initialValue: startEditing || isNewTask)
        self._taskDescription = State(initialValue: tasks.taskDescription ?? "")
        self._creationDate = State(initialValue: tasks.creationDate ?? Date())
        self.presenter = presenter
        self.isNewTask = isNewTask
        self.isFromAPI = isFromAPI
    }
    
    //MARK: - View Body
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                titleSection
                
                if !isFromAPI {
                    dateSection
                    descriptionSection
                    
                } else {
                    apiDataSection
                }
                
                Spacer()
            }
            .padding(20)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isNewTask ? "Add" : "Done") {
                    saveTask()
                }
                .disabled(editedTask.todo.isEmpty) // Disable if empty
            }
        }
    }
    
    //MARK: - Title section
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            if isEditing {
                TextField("Task title", text: $editedTask.todo, axis: .vertical)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .textFieldStyle(.plain)
                    .padding(.vertical, 8)
                    .padding(.leading, 0)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text(editedTask.todo)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 0)
    }
    
    //MARK: - Description section
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
                
            if isEditing {
                
                ZStack(alignment: .topLeading) {
                    
                    TextEditor(text: $taskDescription)
                        .frame(minHeight: 100)
                        .padding(.horizontal, 0)
                        .background(Color.clear)
                    
                    
                    if taskDescription.isEmpty {
                        Text("Enter task description...")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                            .allowsHitTesting(false)
                    }
                }
                
            } else {
                Text(taskDescription.isEmpty ? "No description" : taskDescription)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 0)
            }
        }.frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 0)
    }
    
    //MARK: - Date section
    
    private var dateSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            HStack {
                Text(creationDate.formatted(date: .numeric, time: .omitted))
                    .foregroundColor(.secondary)
            }
            
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.bottom, 4)
    }
    
    //MARK: - API data section
    
    private var apiDataSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("\(editedTask.userId)/\(editedTask.userId)/\(editedTask.userId)")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            Text(editedTask.todo)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //MARK: - Saving the task
    
    private func saveTask() {
        let newTask = ToDoEntity(
            id: isNewTask ? Int.random(in: 1...10000) : editedTask.id,
            todo: editedTask.todo,
            completed: isNewTask ? false : editedTask.completed,
            userId: isNewTask ? 1 : editedTask.userId,
            taskDescription: isFromAPI ? nil : taskDescription,
            creationDate: isFromAPI ? nil : creationDate
        )
        
        if isNewTask {
            presenter?.interactor?.addTodo(newTask)
        } else {
            presenter?.interactor?.editTodo(newTask)
        }
        dismiss()
    }
}


//MARK: -  Preview for API-loaded task
#Preview("API Task") {
    ToDoDetailView(
        tasks: ToDoEntity(
            id: 1,
            todo: "API-loaded task",
            completed: false,
            userId: 23
        ),
        isFromAPI: true
    )
    .preferredColorScheme(.dark)
}

//MARK: - Preview for created task
#Preview("Created Task") {
    ToDoDetailView(
        tasks: ToDoEntity(
            id: 2,
            todo: "New task",
            completed: false,
            userId: 1,
            taskDescription: "This is a detailed description",
            creationDate: Date()
        ),
        isNewTask: true
    )
    .preferredColorScheme(.dark)
}
