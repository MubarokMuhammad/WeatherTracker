//
//  WeatherService.swift
//  WeatherTracker
//
//  Created by mubarok on 15/12/24.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(for city: String) async throws -> WeatherResponse
}

class WeatherService: WeatherServiceProtocol {
    private let apiKey = "58a97c5646da4bd58db100825241512"
    
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=\(apiKey)&q=\(city)") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(WeatherResponse.self, from: data)
    }
}
