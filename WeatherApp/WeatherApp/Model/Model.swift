//
//  Model.swift
//  WeatherApp
//
//  Created by Куаныш Спандияр on 10.04.2025.
//

import Foundation
import SwiftUI

struct WeatherModel: Codable {
    let coord: Coordinates
    let weather: [Weather]
    let main: MainWeather
    let wind: Wind
    let name: String
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let main: String
    let description: String
}

struct MainWeather: Codable {
    let temp: Double
}

struct Wind: Codable {
    let speed: Double
}
