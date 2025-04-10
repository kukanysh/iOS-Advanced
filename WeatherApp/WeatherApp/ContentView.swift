//
//  ContentView.swift
//  WeatherApp
//
//  Created by Куаныш Спандияр on 10.04.2025.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var cityName = "Almaty"
    @State private var weatherBundle: WeatherBundle?
    @State private var errorMessage: String?
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 43.222, longitude: 76.851), // Default to Almaty, Kazakhstan
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )

    var body: some View {
        VStack {
            if let weather = weatherBundle {
                //MARK: - Current Weather
                
                VStack(alignment: .leading) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("\(weather.current?.main.temp ?? 0.0, specifier: "%.1f")°C,")
                            .font(.custom("Futura Medium", size: 40))
                            .foregroundStyle(.white)
                            .bold()
                            .padding(.top)
                        
                        
                        Text("\(weather.current?.name ?? "")")
                            .font(.custom("Futura Medium", size: 30))
                            .foregroundStyle(.white)
                            .padding(.top)
                        
                    }
                    
                    
                    Text("It's ")
                        .font(.custom("Futura Medium", size: 20))
                        .foregroundStyle(.white) + Text("\(weather.current?.weather.first?.description ?? "")")
                        .font(.custom("Futura Medium", size: 20))
                        .foregroundStyle(.white)
                        .bold()
                    
                    if let windSpeed = weather.current?.wind.speed {
                        Text("Wind: ")
                            .font(.custom("Futura Medium", size: 20))
                            .foregroundStyle(.white) + Text("\(windSpeed, specifier: "%.1f") m/s")
                            .font(.custom("Futura Medium", size: 20))
                            .foregroundStyle(.white)
                            .bold()
                    }
                    
                    if let airQuality = weather.airQuality?.list.first?.main.aqi {
                        Text("AQI: ")
                            .font(.custom("Futura Medium", size: 20))
                            .foregroundStyle(.white) + Text("\(airQuality)")
                            .font(.custom("Futura Medium", size: 20))
                            .foregroundStyle(.white)
                            .bold()
                    } else {
                        Text("No data available")
                            .font(.custom("Futura Medium", size: 20))
                            .foregroundStyle(.white)
                    }
                    
                    
                    if let alerts = weather.alerts?.alerts {
                        ForEach(alerts, id: \.event) { alert in
                            Text("\(alert.event): \(alert.description)")
                                .font(.custom("Futura Medium", size: 20))
                                .foregroundStyle(.white)
                        }
                    } else {
                        Text("No alerts.")
                            .font(.custom("Futura Medium", size: 20))
                            .foregroundStyle(.white)
                    }
                    
                    
                }.frame(width: 400)
                    .padding(.leading, -80)
                
                Spacer()

                
                //MARK: - Forecast
                Text("Forecast")
                    .font(.custom("Futura Medium", size: 24))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                    .padding(.leading, -160)
                

                VStack(alignment: .leading, spacing: 10) {
                    
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(weather.forecast?.list.prefix(5) ?? [], id: \.dt) { forecast in
                                VStack(spacing: 10) {
                                    // Day of the Week
                                    Text(forecast.dt.toWeekday())
                                        .font(.custom("Futura Medium", size: 25))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .multilineTextAlignment(.center)
                                    
                                    // Temperature
                                    Text("\(forecast.temp.day, specifier: "%.1f")°C")
                                        .font(.custom("Futura Medium", size: 19))
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .multilineTextAlignment(.center)
                                    
                                    // Weather Description
                                    Text(forecast.weather.first?.description.capitalized ?? "—")
                                        .font(.custom("Futura Medium", size: 14))
                                        .foregroundColor(.white)
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity)
                                        .multilineTextAlignment(.center)
                                }
                                .frame(width: 90, height: 130) // Adjusted frame to fit horizontally
                                .background(
                                    ZStack {
                                        // Frosted Glass Effect
                                        Color.white.opacity(0.1)
                                            .blur(radius: 5) // Apply blur to simulate the frosted glass look
                                            .cornerRadius(20)
                                        
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.white.opacity(0.4), lineWidth: 1) // Border to enhance glass effect
                                            .background(Color.white.opacity(0.1)) // Light frosted look
                                            .cornerRadius(15)
                                    }
                                )
                                .shadow(radius: 5) // Slight shadow to enhance the glass effect
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }.frame(height: 150)
                .padding(15)
                .background(
                    
                    ZStack {
                        // Frosted Glass Effect
                        Color.white.opacity(0.1)
                            .blur(radius: 5) // Apply blur to simulate the frosted glass look
                            .cornerRadius(35)
                        
                        RoundedRectangle(cornerRadius: 35)
                            .stroke(Color.white.opacity(0.4), lineWidth: 1) // Border to enhance glass effect
                            .background(Color.white.opacity(0.1)) // Light frosted look
                            .cornerRadius(35)
                        
                    }
                    
                ).padding([.leading, .trailing])
                .shadow(radius: 5)



                
                
                Spacer()
                
                //MARK: - Weather Map
                Text("Weather Map")
                    .font(.custom("Futura Medium", size: 24))
                    .foregroundColor(.white)
                    .padding(.leading, -160)
                
                WeatherMapView(region: $region)
                    .frame(height: 150)
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(20)
                    .padding()
                
                Spacer()
                
                
            } else if let error = errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .padding()
            } else {
                Text("Loading...")
                    .padding()
            }
            
            Spacer()
            
            //MARK: - Search
            HStack {
                TextField("Enter city name", text: $cityName)
                    .padding(15)
                    .frame(height: 40)
                    .font(.custom("Futura Medium", size: 17))
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 1)
                    .padding()
                
                Button("Search") {
                    Task {
                        await fetchWeatherData(for: cityName)
                    }
                }.font(.custom("Futura Medium", size: 17))
                    .buttonStyle(.plain)
                    .foregroundStyle(.white)
                    .background(
                        RoundedRectangle(cornerRadius: 25, style: .circular)
                            .frame(width: 100, height: 40)
                            .foregroundStyle(.secondary)
                            .opacity(0.4)
                    )
                    .padding()
                
                Button(action: {
                    Task {
                        await fetchWeatherData(for: cityName)
                    }
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .foregroundStyle(.secondary)
                        
                }
                .padding()
                
                
                
            }.padding()
            
                .onAppear {
                    Task {
                        await fetchWeatherData(for: cityName)
                    }
                }
        }
        .background(backgroundView)

            
    }
    
    var backgroundView: some View {
        if let condition = weatherBundle?.current?.weather.first?.main,
           let dt = weatherBundle?.forecast?.list.first?.dt {
            let hour = Calendar.current.component(.hour, from: Date(timeIntervalSince1970: TimeInterval(dt)))
            let imageName = backgroundImageName(for: condition, hour: hour)
            return AnyView(
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
        } else {
            return AnyView(
                Color.blue.opacity(0.1)
            )
        }
    }


    // Fetch weather data for the entered city
    private func fetchWeatherData(for city: String) async {
        do {
            weatherBundle = try await viewModel.fetchAllWeatherData(for: city)
            
            if let latitude = weatherBundle?.current?.coord.lat,
               let longitude = weatherBundle?.current?.coord.lon {
                region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Adjust the zoom level as needed
                )
            }
            
        } catch {
            errorMessage = "Failed to fetch data: \(error.localizedDescription)"
        }
    }
    
    func backgroundImageName(for weather: String, hour: Int) -> String {
        let lowercased = weather.lowercased()
        
        switch lowercased {
        case _ where lowercased.contains("cloud"):
            return "cloudy"
        case _ where lowercased.contains("rain"):
            return "rainy"
        case _ where lowercased.contains("storm"), _ where lowercased.contains("thunder"):
            return "storm"
        case _ where lowercased.contains("clear"):
            if hour >= 6 && hour < 12 {
                return "sunny_day"
            } else if hour >= 12 && hour < 18 {
                return "sunny"
            } else if hour >= 18 && hour < 21 {
                return "dawn"
            } else {
                return "night"
            }
        default:
            return "sunny"
        }
    }

    
}

extension Int {
    func toWeekday() -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
}

struct WeatherMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    private let apiKey = "fed7a921426bf20aadf2228cdac641cd"
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.setRegion(region, animated: true)
        
        let weatherMapURL = "http://maps.openweathermap.org/maps/2.0/weather/TA2/{z}/{x}/{y}?appid=\(apiKey)&fill_bound=false&opacity=0.6"
        
        let tileOverlay = MKTileOverlay(urlTemplate: weatherMapURL)
        tileOverlay.canReplaceMapContent = true
        mapView.addOverlay(tileOverlay, level: .aboveLabels)
        
        mapView.delegate = context.coordinator
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true) // Update the region
    }
    
    func makeCoordinator() -> MapViewDelegate {
        return MapViewDelegate()
    }
}

class MapViewDelegate: NSObject, MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let tileOverlay = overlay as? MKTileOverlay {
            return MKTileOverlayRenderer(overlay: tileOverlay)
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}

#Preview {
    ContentView()
}
