import Vapor
import HTTP
import Foundation

let drop = Droplet()

let weather = WeatherController()
weather.addRoutes(drop:drop)

drop.get { request in
    let json = try drop.client.get("https://api.darksky.net/forecast/\(darkSkyKey)/37.8267,-122.4233", query:["exclude":"minutely,daily,alerts,flags"])
    
    let body        = try JSON(bytes: json.body.bytes!)
    let currently   = body["currently"]! as JSON
    let hourly      = body["hourly"]! as JSON
    
    return try JSON(node: ["currently": currently,
                           "hourly": hourly])
}

drop.run()
