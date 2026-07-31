import Foundation

struct WeatherResponse: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let feelsLike: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case humidity
    }
}

struct Weather: Decodable {
    let main: String
    let description: String
    let icon: String
}
