//
//  FavoriteItem.swift
//  FavoritesList
//
//  Theme: Countries — my travel wishlist.
//

import Foundation

/// One row in the list.
struct FavoriteItem {
    let title: String       // country name
    let subtitle: String    // capital · region
    let imageName: String   // image set name in Assets.xcassets
    let rating: Int         // 0...5 — how much I want to go
}

/// All list data lives here, in one place (not inside the cell).
enum FavoritesLibrary {
    static let items: [FavoriteItem] = [
        FavoriteItem(title: "Japan",                    subtitle: "Tokyo · East Asia",               imageName: "flag_japan",       rating: 5),
        FavoriteItem(title: "Switzerland",              subtitle: "Bern · Central Europe",           imageName: "flag_switzerland", rating: 5),
        FavoriteItem(title: "Iceland",                  subtitle: "Reykjavík · Northern Europe",     imageName: "flag_iceland",     rating: 5),
        FavoriteItem(title: "Norway",                   subtitle: "Oslo · Northern Europe",          imageName: "flag_norway",      rating: 4),
        FavoriteItem(title: "Italy",                    subtitle: "Rome · Southern Europe",          imageName: "flag_italy",       rating: 5),
        FavoriteItem(title: "France",                   subtitle: "Paris · Western Europe",          imageName: "flag_france",      rating: 4),
        FavoriteItem(title: "Greece",                   subtitle: "Athens · Southern Europe",        imageName: "flag_greece",      rating: 4),
        FavoriteItem(title: "United States of America", subtitle: "Washington, D.C. · North America", imageName: "flag_usa",         rating: 3),
        FavoriteItem(title: "Germany",                  subtitle: "Berlin · Central Europe",         imageName: "flag_germany",     rating: 3),
        FavoriteItem(title: "Austria",                  subtitle: "Vienna · Central Europe",         imageName: "flag_austria",     rating: 4),
        FavoriteItem(title: "Netherlands",              subtitle: "Amsterdam · Western Europe",      imageName: "flag_netherlands", rating: 3),
        FavoriteItem(title: "Sweden",                   subtitle: "Stockholm · Northern Europe",     imageName: "flag_sweden",      rating: 3),
        FavoriteItem(title: "Finland",                  subtitle: "Helsinki · Northern Europe",      imageName: "flag_finland",     rating: 2),
        FavoriteItem(title: "Denmark",                  subtitle: "Copenhagen · Northern Europe",    imageName: "flag_denmark",     rating: 2),
        FavoriteItem(title: "Ireland",                  subtitle: "Dublin · Western Europe",         imageName: "flag_ireland",     rating: 2),
        FavoriteItem(title: "Belgium",                  subtitle: "Brussels · Western Europe",       imageName: "flag_belgium",     rating: 1),
        FavoriteItem(title: "Vietnam",                  subtitle: "Hanoi · Southeast Asia",          imageName: "flag_vietnam",     rating: 4),
        FavoriteItem(title: "Thailand",                 subtitle: "Bangkok · Southeast Asia",        imageName: "flag_thailand",    rating: 3),
        FavoriteItem(title: "Chile",                    subtitle: "Santiago · South America",        imageName: "flag_chile",       rating: 1),
        FavoriteItem(title: "Peru",                     subtitle: "Lima · South America",            imageName: "flag_peru",        rating: 0)
    ]
}
