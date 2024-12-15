//
//  HomeView.swift
//  WeatherTracker
//
//  Created by mubarok on 15/12/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = DependencyManager.shared.provideHomeViewModel()
    @State private var searchText: String = ""
    @State private var searchTextColor: Color = Color(red: 0.77, green: 0.77, blue: 0.77)

    
    @State private var isDataShown: Bool = UserDefaults.standard.bool(forKey: "statusShownData")
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 327, height: 46)
                            .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                            .cornerRadius(16)
                        
                        TextField("Search Location", text: $searchText, onCommit: {
                            viewModel.fetchWeather(for: searchText)
                            isDataShown = false
                            searchText = ""
                        })
                        .frame(width: 327, height: 46)
                        .font(Font.custom("Poppins", size: 15))
                        .foregroundColor(searchTextColor)
                        .padding(.leading, 20)
                        .cornerRadius(16)
                        .onChange(of: searchText) { newValue in
                            if newValue.isEmpty {
                                searchTextColor = Color(red: 0.77, green: 0.77, blue: 0.77)
                            } else {
                                searchTextColor = Color(red: 0.17, green: 0.17, blue: 0.17)
                            }
                        }

                        Button(action: {
                            viewModel.fetchWeather(for: searchText)
                            isDataShown = false
                        }) {
                            Image("SearchIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 17.49, height: 17.49)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .offset(x: 134.24, y: -0.26)
                    }
                }
                .offset(x: 0, y: -369)

        
                if let errorMessage = viewModel.errorMessage {
                    ZStack{}
                } else if viewModel.cityName.isEmpty {
                    ZStack() {
                        Text("No City Selected")
                            .font(Font.custom("Poppins", size: 30).weight(.semibold))
                            .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
                            .offset(x: -0.50, y: -46)
                        Text("Please Search For A City")
                            .font(Font.custom("Poppins", size: 15).weight(.semibold))
                            .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
                            .offset(x: -0.50, y: -5)
                        
                    }
                } else {
                    if isDataShown {
                        VStack {
                            ZStack() {
                                VStack(spacing: 20) {
                                    ZStack() {
                                        AsyncImage(url: URL(string: viewModel.weatherIcon)) { image in
                                              image
                                                  .resizable()
                                                  .scaledToFit()
                                          } placeholder: {
                                              ProgressView()
                                          }
                                    }
                                    .frame(width: 123, height: 123)
                                    
                                    HStack(spacing: 11) {
                                        Text(viewModel.cityName)
                                            .font(Font.custom("Poppins", size: 30).weight(.semibold))
                                            .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
                        
                                            
                                        Image("ArrowMaps")
                                            .resizable()
                                            .frame(width: 21, height: 21)
                                    
                                    }
                                    .frame(maxWidth: .infinity)
                                    
                                    ZStack() {
                                        if let temperatureValue = viewModel.temperature.split(separator: "°").first {
                                               Text(String(temperatureValue))
                                                    .font(Font.custom("Poppins", size: 60).weight(.medium))
                                                    .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
                                                    .offset(x: -0.50, y: 0)
                                           }
                                           
                                        Ellipse()
                                            .foregroundColor(.clear)
                                            .frame(width: 8, height: 8)
                                            .overlay(
                                                Ellipse()
                                                    .inset(by: 0.75)
                                                    .stroke(Color(red: 0.17, green: 0.17, blue: 0.17), lineWidth: 0.75)
                                            )
                                            .offset(x: 75.50, y: -29)
                                    }
                                    .frame(width: 175, height: 70)
                                }
                                .frame(height: 261)
                                .offset(x: 16.50, y: -105.50)
                                HStack(spacing: 56) {
                                    VStack(spacing: 2) {
                                        Text("Humidity")
                                            .font(Font.custom("Poppins", size: 12).weight(.medium))
                                            .foregroundColor(Color(red: 0.77, green: 0.77, blue: 0.77))
                                        Text(viewModel.humidity)
                                            .font(Font.custom("Poppins", size: 15).weight(.medium))
                                            .foregroundColor(Color(red: 0.60, green: 0.60, blue: 0.60))
                                    }
                                    .frame(width: 60)
                                    
                                    VStack(spacing: 2) {
                                        Text("UV")
                                            .font(Font.custom("Poppins", size: 12).weight(.medium))
                                            .foregroundColor(Color(red: 0.77, green: 0.77, blue: 0.77))
                                        Text(viewModel.uvIndex)
                                            .font(Font.custom("Poppins", size: 15).weight(.medium))
                                            .foregroundColor(Color(red: 0.60, green: 0.60, blue: 0.60))
                                    }
                                    .frame(width: 25)
                                    
                                    VStack(spacing: 2) {
                                        Text("Feels Like")
                                            .font(Font.custom("Poppins", size: 8).weight(.medium))
                                            .foregroundColor(Color(red: 0.77, green: 0.77, blue: 0.77))
                                        Text(viewModel.feelsLike)
                                            .font(Font.custom("Poppins", size: 15).weight(.medium))
                                            .foregroundColor(Color(red: 0.60, green: 0.60, blue: 0.60))
                                    }
                                    .frame(width: 71)
                                }
                                .padding(16)
                                .frame(width: 274)
                                .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                                .cornerRadius(16)
                                .offset(x: 5.50, y: 97.50)
                                
                            }
                        }
                    } else {
                        HStack(spacing: 106) {
                            VStack(alignment: .leading, spacing: 13) {
                                Text(viewModel.cityName)
                                    .font(Font.custom("Poppins", size: 20).weight(.semibold))
                                    .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
                                HStack(alignment: .top, spacing: 8) {
                                    if let temperatureValue = viewModel.temperature.split(separator: "°").first {
                                           Text(String(temperatureValue))
                                               .font(Font.custom("Poppins", size: 30).weight(.medium))
                                               .foregroundColor(Color(red: 0.17, green: 0.17, blue: 0.17))
                                       }
                                    
                                    Ellipse()
                                        .foregroundColor(.clear)
                                        .frame(width: 5, height: 5)
                                        .overlay(
                                            Ellipse()
                                                .inset(by: 0.50)
                                                .stroke(.black, lineWidth: 0.50)
                                        )
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .frame(width: 85)
                            ZStack() {
                                    AsyncImage(url: URL(string: viewModel.weatherIcon)) { image in
                                          image
                                              .resizable()
                                              .scaledToFit()
                                              .frame(width: 97, height: 97)
                                      } placeholder: {
                                          ProgressView()
                                      }
                                }
                                .frame(width: 83, height: 67)
                        }
                        .padding(16)
                        .frame(width: 336, height: 117)
                        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                        .cornerRadius(16)
                        .offset(x: 0, y: -259)
                        .onTapGesture {
                            isDataShown = true
                            UserDefaults.standard.set(true, forKey: "statusShownData")
                        }
                    }
                }

                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


