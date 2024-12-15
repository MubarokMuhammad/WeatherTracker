//
//  MockWeatherService.swift
//  WeatherTracker
//
//  Created by mubarok on 15/12/24.
//

import Foundation
@testable import WeatherTracker

class MockWeatherService: WeatherServiceProtocol {
    var shouldReturnError = false
    
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        return WeatherResponse(
            location: Location(name: "Test City"),
            current: CurrentWeather(
                temp_c: 25.0,
                condition: Condition(text: "Sunny", icon: "/test-icon.png"),
                humidity: 60,
                uv: 5.0,
                feelslike_c: 27.0
            )
        )
    }
}
