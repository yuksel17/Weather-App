import Foundation
import Combine

class WeatherViewModel: ObservableObject {

    @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let weatherService = WeatherService()

    // Şehir adına göre hava durumu
    func fetchWeather(city: String = "Istanbul") {

        isLoading = true
        errorMessage = nil

        weatherService.fetchWeather(city: city) { [weak self] response in
            guard let self = self else { return }

            self.isLoading = false

            if let response = response {
                self.weather = response
            } else {
                self.errorMessage = "Hava durumu alınamadı."
            }
        }
    }

    // Koordinata göre hava durumu
    func fetchWeather(latitude: Double, longitude: Double) {

        isLoading = true
        errorMessage = nil

        weatherService.fetchWeather(latitude: latitude, longitude: longitude) { [weak self] response in
            guard let self = self else { return }

            self.isLoading = false

            if let response = response {
                self.weather = response
            } else {
                self.errorMessage = "Hava durumu alınamadı."
            }
        }
    }
}
