//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Куаныш Спандияр on 10.04.2025.
//

import Foundation

struct WeatherBundle {
    var current: WeatherModel?
    var forecast: ForecastResponse?
    var airQuality: AirQualityResponse?
    var alerts: AlertResponse?
}

final class ViewModel: ObservableObject {
    
    @Published var weather: WeatherBundle = WeatherBundle()
    
    func fetchAllWeatherData(for city: String) async throws -> WeatherBundle {
        var result = WeatherBundle()
        
        // Step 1: Get coordinates first (from current weather)
        let currentData = try await fetchCurrentWeather(for: city)
        result.current = currentData
        let lat = currentData.coord.lat
        let lon = currentData.coord.lon

        // Step 2: Fetch other data concurrently
        try await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask {
                result.forecast = try await self.fetchForecast(for: city)
            }
            group.addTask {
                result.airQuality = try await self.fetchAirQuality(lat: lat, lon: lon)
            }
            group.addTask {
                result.alerts = try await self.fetchAlerts(lat: lat, lon: lon)
            }
        }
        
        return result
    }
    
    
    
    
    func fetchCurrentWeather(for city: String) async throws -> WeatherModel {
        let url = WeatherAPI.currentWeatherURL(for: city)
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(WeatherModel.self, from: data)
    }

    func fetchForecast(for city: String) async throws -> ForecastResponse {
        let url = WeatherAPI.forecastURL(for: city)
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(ForecastResponse.self, from: data)
    }

    func fetchAirQuality(lat: Double, lon: Double) async throws -> AirQualityResponse {
        let url = WeatherAPI.airQualityURL(lat: lat, lon: lon)
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(AirQualityResponse.self, from: data)
    }

    func fetchAlerts(lat: Double, lon: Double) async throws -> AlertResponse {
        let url = WeatherAPI.alertsURL(lat: lat, lon: lon)
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(AlertResponse.self, from: data)
    }

    
    
}

enum WeatherAPI {
    static let apiKey = "fed7a921426bf20aadf2228cdac641cd"
    static let base = "https://api.openweathermap.org/data/2.5"
    
    static func currentWeatherURL(for city: String) -> URL {
        URL(string: "\(base)/weather?q=\(city)&appid=\(apiKey)&units=metric")!
    }

    static func forecastURL(for city: String) -> URL {
        URL(string: "\(base)/forecast/daily?q=\(city)&appid=\(apiKey)&units=metric")!
    }

    static func airQualityURL(lat: Double, lon: Double) -> URL {
        URL(string: "\(base)/air_pollution?lat=\(lat)&lon=\(lon)&appid=\(apiKey)")!
    }

    static func alertsURL(lat: Double, lon: Double) -> URL {
        // OpenWeather OneCall includes alerts
        URL(string: "\(base)/onecall?lat=\(lat)&lon=\(lon)&exclude=minutely,hourly,daily&appid=\(apiKey)&units=metric")!
    }
}
