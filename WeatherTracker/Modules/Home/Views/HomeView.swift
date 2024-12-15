//
//  HomeView.swift
//  WeatherTracker
//
//  Created by mubarok on 15/12/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = DependencyManager.shared.provideHomeViewModel()

    @State private var searchText = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                } else if viewModel.cityName.isEmpty {
                    Text("Search for a city to display its weather")
                        .padding()
                } else {
                    VStack {
                        Text(viewModel.cityName)
                            .font(.largeTitle)
                        AsyncImage(url: URL(string: viewModel.weatherIcon)) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        Text(viewModel.temperature)
                            .font(.system(size: 40))
                        Text(viewModel.weatherCondition)
                            .font(.headline)
                        Text("Feels like: \(viewModel.feelsLike)")
                        Text("Humidity: \(viewModel.humidity)")
                        Text("UV Index: \(viewModel.uvIndex)")
                    }
                }

                TextField("Search city", text: $searchText, onCommit: {
                    viewModel.fetchWeather(for: searchText)
                    searchText = ""
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            }
            .navigationTitle("Weather Tracker")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


