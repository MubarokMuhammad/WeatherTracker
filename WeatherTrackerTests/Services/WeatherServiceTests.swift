//
//  WeatherServiceTests.swift
//  WeatherTracker
//
//  Created by mubarok on 15/12/24.
//

import XCTest
@testable import WeatherTracker

final class WeatherServiceTests: XCTestCase {
    private var mockWeatherService: MockWeatherService!
    
    override func setUp() {
        super.setUp()
        mockWeatherService = MockWeatherService()
    }
    
    func testFetchWeatherSuccess() async {
        do {
            let weather = try await mockWeatherService.fetchWeather(for: "Test City")
            XCTAssertEqual(weather.location.name, "Test City")
            XCTAssertEqual(weather.current.temp_c, 25.0)
            XCTAssertEqual(weather.current.condition.text, "Sunny")
            XCTAssertEqual(weather.current.humidity, 60)
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func testFetchWeatherFailure() async {
        mockWeatherService.shouldReturnError = true
        
        do {
            _ = try await mockWeatherService.fetchWeather(for: "Test City")
            XCTFail("Expected error but got success")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }
}
