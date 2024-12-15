//
//  HomeViewModel.swift
//  WeatherTracker
//
//  Created by mubarok on 15/12/24.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published var temperature: String = ""
    @Published var weatherCondition: String = ""
    @Published var humidity: String = ""
    @Published var uvIndex: String = ""
    @Published var feelsLike: String = ""
    @Published var weatherIcon: String = ""
    @Published var errorMessage: String?

    private let weatherService: WeatherServiceProtocol
    private let networkMonitor: NetworkMonitor
    private let userDefaultsKey = "SavedCity"

    init(weatherService: WeatherServiceProtocol = WeatherService(), networkMonitor: NetworkMonitor = NetworkMonitor()) {
        self.weatherService = weatherService
        self.networkMonitor = networkMonitor
        loadSavedCity()
        
        networkMonitor.$isConnected
            .sink { [weak self] isConnected in
                if !isConnected {
                    self?.errorMessage = "No internet connection."
                } else {
                    self?.errorMessage = nil
                }
            }
            .store(in: &cancellables)
    }

    private var cancellables: Set<AnyCancellable> = []

    func loadSavedCity() {
        if let savedCity = UserDefaults.standard.string(forKey: userDefaultsKey) {
            fetchWeather(for: savedCity)
        }
    }

    func fetchWeather(for city: String) {
        Task {
            do {
                let weather = try await weatherService.fetchWeather(for: city)
                DispatchQueue.main.async {
                    self.updateWeather(weather)
                    self.saveCity(city)
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
                }
                print("Error fetching weather: \(error)")
            }
        }
    }

    private func updateWeather(_ weather: WeatherResponse) {
        cityName = weather.location.name
        temperature = "\(weather.current.temp_c)°C"
        weatherCondition = weather.current.condition.text
        humidity = "\(weather.current.humidity)%"
        uvIndex = "\(weather.current.uv)"
        feelsLike = "\(weather.current.feelslike_c)°C"
        weatherIcon = "https:\(weather.current.condition.icon)"
        errorMessage = nil 
    }

    private func saveCity(_ city: String) {
        UserDefaults.standard.set(city, forKey: userDefaultsKey)
    }

    deinit {
        networkMonitor.stopMonitoring()
    }
}


