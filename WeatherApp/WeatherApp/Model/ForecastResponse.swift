//
//  ForecastResponse.swift
//  WeatherApp
//
//  Created by Куаныш Спандияр on 10.04.2025.
//

import Foundation

struct ForecastResponse: Codable {
    let list: [DailyForecast]
}

struct DailyForecast: Codable {
    let dt: Int
    let temp: Temperature
    let weather: [Weather]
}

struct Temperature: Codable {
    let day: Double
}
