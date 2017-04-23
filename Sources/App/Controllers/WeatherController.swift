import Vapor
import HTTP

final class WeatherController {
    
    func addRoutes(drop: Droplet) {
        drop.group("weather") { group in
            group.get("sunny", handler: sunny)
            group.get("cloudy", handler: weatherCloudy)
            group.get(String.self, handler: argument)
            group.post("post", handler: postWeather)
        }
    }
    
    func sunny(request: Request) throws -> ResponseRepresentable {
        return "The sun is shining..."
    }
    
    func weatherCloudy(request: Request) throws -> ResponseRepresentable {
        return "It's cloudy today!"
    }
    
    func argument(request: Request, argument: String) throws -> ResponseRepresentable {
        return try JSON(node: ["message": "It's \(argument) today"])
    }
    
    func postWeather(request: Request) throws -> ResponseRepresentable  {
        guard let city = request.data["city"]?.string else {
            throw Abort.badRequest
        }
        return try JSON(node: ["message": "It's sunny in \(city) today."])
    }
}
