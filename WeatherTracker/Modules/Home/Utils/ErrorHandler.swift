//
//  ErrorHandler.swift
//  WeatherTracker
//
//  Created by mubarok on 15/12/24.
//

import Foundation

enum WeatherError: Error, LocalizedError {
    case invalidCity
    case networkError
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .invalidCity:
            return "The city name is invalid. Please try again."
        case .networkError:
            return "Unable to fetch data. Please check your internet connection."
        case .unknownError:
            return "An unknown error occurred. Please try again later."
        }
    }
}

class ErrorHandler {
    static func handle(_ error: Error) -> String {
        if let localizedError = error as? LocalizedError, let description = localizedError.errorDescription {
            return description
        }
        return "An unexpected error occurred."
    }
}
