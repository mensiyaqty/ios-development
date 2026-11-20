//
//  Favorite.swift
//  FoodRoulette
//

import Foundation

/// One favorite item shown on the card.
struct Favorite {
    let title: String
    let description: String
    let imageName: String   // name of the image set in Assets.xcassets
}

extension Favorite {
    /// Category: Food — exactly 10 favorites.
    static let all: [Favorite] = [
        Favorite(title: "Beshbarmak",
                 description: "Hand-cut noodles with tender boiled meat and onion broth. Kyrgyzstan's national dish.",
                 imageName: "beshbarmak"),
        Favorite(title: "Plov",
                 description: "Rice slow-cooked with lamb, carrots and whole garlic in a big kazan.",
                 imageName: "plov"),
        Favorite(title: "Manty",
                 description: "Big steamed dumplings stuffed with juicy minced meat and onion.",
                 imageName: "manty"),
        Favorite(title: "Lagman",
                 description: "Hand-pulled noodles topped with a spicy stir-fry of meat and vegetables.",
                 imageName: "lagman"),
        Favorite(title: "Samsa",
                 description: "Flaky pastry baked in a tandoor, filled with meat and onion.",
                 imageName: "samsa"),
        Favorite(title: "Bibimbap",
                 description: "A rice bowl with vegetables, a fried egg and gochujang. Mix it all together.",
                 imageName: "bibimbap"),
        Favorite(title: "Tteokbokki",
                 description: "Chewy rice cakes in a sweet and spicy red sauce. The classic street snack.",
                 imageName: "tteokbokki"),
        Favorite(title: "Kimchi Jjigae",
                 description: "Bubbling kimchi stew with pork and tofu. Perfect on a cold day.",
                 imageName: "kimchijjigae"),
        Favorite(title: "Samgyeopsal",
                 description: "Grilled pork belly wrapped in lettuce with garlic and ssamjang.",
                 imageName: "samgyeopsal"),
        Favorite(title: "Bingsu",
                 description: "Shaved milk ice topped with sweet red beans, fruit and condensed milk.",
                 imageName: "bingsu")
    ]
}
