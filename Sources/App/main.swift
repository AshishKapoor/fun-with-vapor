import Vapor

let drop = Droplet()

drop.get { req in
    return "it's raining men hallelujah!"
}

drop.get ("sunny") { req in
    return "The sun is shining..."
}

drop.get ("weather", "cloudy") { req in
    return "It's cloudy today!"
}

drop.get ("weather", String.self) { req, weather in
    return try JSON(node: ["message": "It's \(weather) today"])
}

drop.post("post") { req in
    guard let city = req.data["city"]?.string else {
        throw Abort.badRequest
    }
    return try JSON(node: ["message": "It's sunny in \(city) today."])
}

drop.group("cities") { city in
    city.get("new-delhi") { req in
        return "Hello, New Delhi"
    }
    city.get("mumbai") { req in
        return "Hello, Mumbai"
    }
}

//drop.resource("posts", PostController())

drop.run()
