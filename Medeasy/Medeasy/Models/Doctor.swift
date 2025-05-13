//
//  Doctor.swift
//  Medeasy
//
//  Created by Zhaina Igenbek on 11.05.2025.
//

import Foundation

struct Doctor: Identifiable, Decodable {
    let id: Int
    let fullName: String
    let shortName: String
    let specialty: String
    let imageName: String
    let about: String
    let reviews: [Review]?
}

struct Review: Decodable {
    let author: String
    let text: String
}
