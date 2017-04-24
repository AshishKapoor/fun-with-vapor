import Vapor
import HTTP
import Foundation

let drop = Droplet()

let weather = WeatherController()
weather.addRoutes(drop:drop)

drop.get { request in
    
    let darkSkyKey  = "7a100d1586e740565de176a0ed1c509e"
    let darkSkyURL  = "https://api.darksky.net/forecast/\(darkSkyKey)/37.8267,-122.4233"
    let json        = try drop.client.get(darkSkyURL, query:["exclude":"minutely, daily, alerts, flags"])
    let body        = try JSON(bytes: json.body.bytes!)
    let currently   = body["currently"]! as JSON
    let hourly      = body["hourly"]! as JSON
    
    return try drop.view.make("welcome", Node(node:
        [
            "time"               : TimeKeeper().getSystemTime(),
            "temp"               : currently["apparentTemperature"],
             "current-summary"   : currently["summary"],
             "hourly-summary"    : hourly["summary"],
             "icon"              : currently["icon"]
        ]))
}

drop.run()
