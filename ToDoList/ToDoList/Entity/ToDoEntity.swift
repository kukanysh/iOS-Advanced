//
//  ToDoEntity.swift
//  ToDoList
//
//  Created by Куаныш Спандияр on 06.08.2025.
//

import Foundation

struct ToDoEntity: Identifiable, Codable, Hashable {
    var id: Int
    var todo: String
    var completed: Bool
    let userId: Int
}
