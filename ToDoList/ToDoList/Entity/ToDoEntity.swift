//
//  ToDoEntity.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 06.08.2025.
//

import Foundation

struct ToDoEntity: Identifiable, Decodable {
    let id = UUID()
    let task: String
    let completed: Bool
    let userId: Int
}
