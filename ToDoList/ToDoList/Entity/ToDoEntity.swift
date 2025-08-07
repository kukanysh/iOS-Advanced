//
//  ToDoEntity.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 06.08.2025.
//

import Foundation

struct ToDoEntity: Identifiable, Decodable {
    var id = UUID()
    let task: String
    var completed: Bool
    let userId: Int
}

struct TodoResponse: Decodable {
    let todos: [ToDoEntity]
}
