import Foundation

class WeatherService {

    private let apiKey = "b5bd45ca443317b337c7962c6bae9931"

    // Şehir adına göre hava durumu
    func fetchWeather(city: String, completion: @escaping (WeatherResponse?) -> Void) {

        let cityName = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city

        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)&units=metric&lang=tr"

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in

            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            do {
                let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)

                DispatchQueue.main.async {
                    completion(weather)
                }

            } catch {
                print(error)

                DispatchQueue.main.async {
                    completion(nil)
                }
            }

        }.resume()
    }

    // Koordinata göre hava durumu
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherResponse?) -> Void) {

        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric&lang=tr"

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in

            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            do {
                let weather = try JSONDecoder().decode(WeatherResponse.self, from: data)

                DispatchQueue.main.async {
                    completion(weather)
                }

            } catch {
                print(error)

                DispatchQueue.main.async {
                    completion(nil)
                }
            }

        }.resume()
    }
}
