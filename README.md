# Weather Tracker iOS App

## Overview

**Weather Tracker** is a simple yet powerful iOS app built using **Swift**, **SwiftUI**, and **clean architecture**. The app allows users to search for a city, display its weather details, and persist the selected city across app launches. It fetches weather data from the **WeatherAPI.com** and presents key weather information such as temperature, weather condition, humidity, UV index, and "feels like" temperature.

## Features

- **Search for Cities**: Users can search for a city by name.
- **Display Weather Information**: Shows weather details including:
  - City Name
  - Temperature (in °C)
  - Weather Condition (with an icon)
  - Humidity (%)
  - UV Index
  - "Feels Like" Temperature (in °C)
- **Persistence**: The app saves the selected city using **UserDefaults**, so the city is remembered even after the app is closed and reopened.
- **Network Monitoring**: The app monitors the network connection status and notifies users if there is no internet connection available.

## Screenshots

- **Home Screen (With Weather Info)**:
  ![Home Screen](path_to_screenshot_home_screen)

- **Search Screen (With Search Bar)**:
  ![Search Screen](path_to_screenshot_search_screen)

## Tech Stack

- **Swift**: The primary programming language for building the app.
- **SwiftUI**: Used for building the user interface.
- **WeatherAPI.com**: API for fetching weather data.
- **MVVM Architecture**: For clear separation of concerns and testable code.
- **Protocol-Oriented Programming**: Utilized for defining abstractions and dependency injection.
- **Combine**: Used for reactive programming and handling asynchronous tasks.
- **Network Monitoring**: To handle network status changes and provide feedback to the user.

## Architecture

This app follows the **Model-View-ViewModel (MVVM)** design pattern for separation of concerns and modularity.

- **Model**: Represents the weather data, fetched from the **WeatherAPI**.
- **View**: Built using **SwiftUI**, this is the user interface that displays the weather data to the user.
- **ViewModel**: Contains the business logic, communicates with the service layer (fetching data), and updates the view with weather data. The **HomeViewModel** handles network status and stores data locally using **UserDefaults**.

### Components:
- **HomeViewModel**: Manages the weather data and interacts with the weather service.
- **WeatherService**: A service that fetches weather data from **WeatherAPI.com**.
- **NetworkMonitor**: Monitors the network status and alerts the user if there is no connection.

## Features in Detail

### Home Screen
- Displays the weather for the saved city (if any), including:
  - **City Name**: The name of the city.
  - **Temperature**: Current temperature in °C.
  - **Weather Condition**: Descriptive condition (e.g., sunny, rainy, etc.) with an icon.
  - **Humidity**: Current humidity in percentage.
  - **UV Index**: Current UV index.
  - **Feels Like**: The temperature as it feels to the human body.

### Search Behavior
- A search bar allows the user to search for a city by name.
- When a city is selected, the weather data is fetched and displayed.
- The selected city is saved to **UserDefaults**, ensuring the city is remembered across app launches.

### Network Monitoring
- The app listens to changes in the network connection and displays an appropriate error message if there is no internet connection.

### Error Handling
- The app gracefully handles errors such as invalid city names or network issues, displaying an error message if needed.

## Setup & Installation

### Requirements:
- **iOS 15.0** or higher
- **Xcode 15.0** or higher
- **Swift 5.x** or higher

### Installation:
1. Clone the repository:
   ```bash
   git clone https://github.com/MubarokMuhammad/WeatherTracker.git
   ```
2. Open the project in **Xcode**.
3. Build and run the project on the simulator or a real device.

### API Key Setup:
To use the weather data, you need to sign up for a free account on **WeatherAPI.com** and generate an API key.

1. Visit [WeatherAPI.com](https://www.weatherapi.com/).
2. Sign up and create an API key.
3. Replace the API key in `WeatherService.swift` file where necessary.

```swift
let apiKey = "YOUR_API_KEY_HERE"
```

## Testing

The project includes unit tests and integration tests to ensure the functionality of the app.

### Unit Tests:
- Mocking the `WeatherServiceProtocol` allows testing with dummy data to verify the app's behavior without making actual network requests.

### Integration Tests:
- Verifies that the app fetches data and persists the selected city properly.

## Error Handling
The app handles errors such as:
- **No Network Connection**: Alerts the user when the app cannot fetch weather data due to lack of internet connectivity.
- **Invalid City**: Alerts the user when the city entered is not valid or cannot be found.

## Dependencies

- **Combine**: For handling asynchronous operations.
- **SwiftUI**: For building the UI.
- **WeatherAPI.com**: For fetching weather data.

## Future Improvements

- Add support for multiple cities and allow users to switch between them.
- Improve UI/UX for a better user experience.
- Add additional weather data such as hourly forecasts.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


