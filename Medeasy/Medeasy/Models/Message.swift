//
//  Message.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 04.08.2025.
//

import Foundation

enum Roles {
    case ai
    case user
}

struct Message: Identifiable, Equatable {
    
    let id = UUID()
    let role: Roles
    let message: String
    
}

