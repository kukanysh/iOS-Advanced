//
//  AlertResponse.swift
//  WeatherApp
//
//  Created by Куаныш Спандияр on 10.04.2025.
//

import Foundation

struct AlertResponse: Codable {
    let alerts: [WeatherAlert]?
}

struct WeatherAlert: Codable {
    let event: String
    let description: String
}

