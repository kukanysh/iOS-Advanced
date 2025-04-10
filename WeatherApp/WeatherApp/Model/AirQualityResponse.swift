//
//  AirQualityResponse.swift
//  WeatherApp
//
//  Created by Куаныш Спандияр on 10.04.2025.
//

import Foundation

struct AirQualityResponse: Codable {
    let list: [AirQualityData]
}

struct AirQualityData: Codable {
    let main: AQMain
}

struct AQMain: Codable {
    let aqi: Int
}
