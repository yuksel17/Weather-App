import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = WeatherViewModel()
    @State private var city = ""
    private var backgroundColors: [Color] {

        switch viewModel.weather?.weather.first?.main {

        case "Clear":
            return [.yellow, .cyan, .blue]

        case "Clouds":
            return [.gray, .black, .black]

        case "Rain":
            return [.blue, .gray, .black]

        case "Snow":
            return [.white, .gray]

        case "Thunderstorm":
            return [.black, .gray,.white]

        default:
            return [.blue, .cyan]
        }
    }

    var body: some View {
        NavigationStack {

            ZStack {

                LinearGradient(
                    colors: backgroundColors,
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 25) {

                    TextField("Şehir giriniz", text: $city)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)

                    HStack(spacing: 15) {

                        Button {
                            if !city.isEmpty {
                                viewModel.fetchWeather(city: city)
                            }
                        } label: {
                            Label("Ara", systemImage: "magnifyingglass")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)

                        NavigationLink {
                            MapView { latitude, longitude in
                                viewModel.fetchWeather(latitude: latitude, longitude: longitude)
                            }
                        } label: {
                            Label("Harita", systemImage: "map")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(.horizontal)

                    if viewModel.isLoading {

                        Spacer()

                        ProgressView("Yükleniyor...")
                            .tint(.white)

                        Spacer()

                    } else if let weather = viewModel.weather {

                        VStack(spacing: 20) {

                            Text("📍 \(weather.name)")
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(.white)

                            Group {
                                switch weather.weather.first?.main {
                                case "Clear":
                                    Image(systemName: "sun.max.fill")
                                        .foregroundStyle(.yellow)

                                case "Clouds":
                                    Image(systemName: "cloud.fill")
                                        .foregroundStyle(.white)

                                case "Rain":
                                    Image(systemName: "cloud.rain.fill")
                                        .foregroundStyle(.white)

                                case "Snow":
                                    Image(systemName: "snowflake")
                                        .foregroundStyle(.white)

                                case "Thunderstorm":
                                    Image(systemName: "cloud.bolt.rain.fill")
                                        .foregroundStyle(.yellow)

                                default:
                                    Image(systemName: "cloud.fill")
                                        .foregroundStyle(.white)
                                }
                            }
                            .font(.system(size: 70))

                            Text("\(Int(weather.main.temp))°C")
                                .font(.system(size: 60, weight: .bold))
                                .foregroundStyle(.white)

                            Text(weather.weather.first?.description.capitalized ?? "")
                                .foregroundStyle(.white)

                            HStack(spacing: 40) {

                                VStack {
                                    Text("Nem")
                                        .font(.caption)

                                    Text("%\(weather.main.humidity)")
                                        .bold()
                                }

                                VStack {
                                    Text("Hissedilen")
                                        .font(.caption)

                                    Text("\(Int(weather.main.feelsLike))°C")
                                        .bold()
                                }
                            }
                            .foregroundStyle(.white)
                        }
                        .frame(maxWidth: .infinity, minHeight: 500)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 30)
                        .background(.white.opacity(0.18))
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .shadow(color: .black.opacity(0.25), radius: 20, y: 10)

                        Spacer()

                    } else if let error = viewModel.errorMessage {

                        Spacer()

                        Text(error)
                            .foregroundStyle(.red)

                        Spacer()
                    }
                }
                .padding(.top)
            }
            .onAppear {
                viewModel.fetchWeather()
            }
        }
    }
}

#Preview {
    ContentView()
}
