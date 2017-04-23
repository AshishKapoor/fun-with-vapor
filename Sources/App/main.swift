import Vapor

let drop = Droplet()

let weather = WeatherController()

weather.addRoutes(drop:drop)

drop.run()
