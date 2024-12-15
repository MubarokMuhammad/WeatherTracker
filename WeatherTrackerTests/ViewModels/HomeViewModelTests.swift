//
//  HomeViewModelTests.swift
//  WeatherTracker
//
//  Created by mubarok on 15/12/24.
//

import XCTest
@testable import WeatherTracker

final class HomeViewModelTests: XCTestCase {
    private var mockWeatherService: MockWeatherService!
    private var viewModel: HomeViewModel!
    private let userDefaultsKey = "SavedCity"
    
    override func setUp() {
        super.setUp()
        mockWeatherService = MockWeatherService()
        viewModel = HomeViewModel(weatherService: mockWeatherService)
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
    
    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
        super.tearDown()
    }
    
    func testFetchWeatherUpdatesViewModel() async {
        await viewModel.fetchWeather(for: "Test City")
        
        XCTAssertEqual(viewModel.cityName, "Test City")
        XCTAssertEqual(viewModel.temperature, "25.0°C")
        XCTAssertEqual(viewModel.weatherCondition, "Sunny")
        XCTAssertEqual(viewModel.humidity, "60%")
        XCTAssertEqual(viewModel.uvIndex, "5.0")
        XCTAssertEqual(viewModel.feelsLike, "27.0°C")
    }
    
    func testPersistenceOfSelectedCity() async {
        await viewModel.fetchWeather(for: "Persisted City")
        
        let savedCity = UserDefaults.standard.string(forKey: userDefaultsKey)
        XCTAssertEqual(savedCity, "Persisted City")
        
        let newViewModel = HomeViewModel(weatherService: mockWeatherService)
        XCTAssertEqual(newViewModel.cityName, "Persisted City")
    }
    
    func testLoadSavedCity() async {
        UserDefaults.standard.set("Saved City", forKey: userDefaultsKey)
        
        let newViewModel = HomeViewModel(weatherService: mockWeatherService)
        await newViewModel.loadSavedCity()
        
        XCTAssertEqual(newViewModel.cityName, "Saved City")
    }
}
