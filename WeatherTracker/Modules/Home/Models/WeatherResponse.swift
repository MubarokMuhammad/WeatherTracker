//
//  WeatherResponse.swift
//  WeatherTracker
//
//  Created by mubarok on 15/12/24.
//

struct WeatherResponse: Codable {
    let location: Location
    let current: CurrentWeather
}

struct Location: Codable {
    let name: String
}

struct CurrentWeather: Codable {
    let temp_c: Double
    let condition: Condition
    let humidity: Int
    let uv: Double
    let feelslike_c: Double
}

struct Condition: Codable {
    let text: String
    let icon: String
}
