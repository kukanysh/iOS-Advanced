//
//  DoctorViewModel.swift
//  Medeasy
//
//  Created by Zhaina Igenbek on 11.05.2025.
//

import Foundation

class DoctorViewModel: ObservableObject {
    @Published var doctors: [Doctor] = []

    init() {
        loadDoctors()
    }

    func loadDoctors() {
        guard let url = Bundle.main.url(forResource: "doctors", withExtension: "json") else {
            print("doctors.json not found")
                return
           }

        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode([Doctor].self, from: data)
            self.doctors = decoded
        } catch {
             print("Failed to decode JSON: \(error)")
        }
    }
}
