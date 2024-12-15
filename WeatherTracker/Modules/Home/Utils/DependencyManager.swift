//
//  DependencyManager.swift
//  WeatherTracker
//
//  Created by mubarok on 15/12/24.
//

import Foundation

class DependencyManager {
    static let shared = DependencyManager()

    func provideWeatherService() -> WeatherServiceProtocol {
        return WeatherService()
    }

    func provideHomeViewModel() -> HomeViewModel {
        let weatherService = provideWeatherService() 
        return HomeViewModel(weatherService: weatherService)
    }
}

