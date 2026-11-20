//
//  FavoriteItem.swift
//  FavoritesNavigator
//
//  Theme: Countries — my travel wishlist.
//

import Foundation

/// One country in the list.
struct FavoriteItem {
    let title: String        // country name
    let subtitle: String     // capital · region
    let imageName: String    // image set name in Assets.xcassets
    let rating: Int          // 0...5 — how much I want to go
    let description: String  // at least 3 sentences
}

/// All list data lives here, in one place.
enum FavoritesLibrary {
    static let items: [FavoriteItem] = [
        FavoriteItem(
            title: "Japan",
            subtitle: "Tokyo · East Asia",
            imageName: "flag_japan",
            rating: 5,
            description: "Japan is an island nation made up of four main islands and thousands of smaller ones. I want to see the cherry blossoms in Kyoto and ride the Shinkansen bullet train. The food alone, from ramen to fresh sushi, is worth the trip."
        ),
        FavoriteItem(
            title: "Switzerland",
            subtitle: "Bern · Central Europe",
            imageName: "flag_switzerland",
            rating: 5,
            description: "Switzerland sits in the heart of the Alps and has four national languages. Its trains climb all the way up to glaciers and high mountain stations like the Jungfraujoch. I dream of hiking above Lake Geneva and tasting real Swiss chocolate."
        ),
        FavoriteItem(
            title: "Iceland",
            subtitle: "Reykjavík · Northern Europe",
            imageName: "flag_iceland",
            rating: 5,
            description: "Iceland is a volcanic island just south of the Arctic Circle. It is famous for geysers, waterfalls, glaciers and black sand beaches. In winter the northern lights dance across the sky."
        ),
        FavoriteItem(
            title: "Norway",
            subtitle: "Oslo · Northern Europe",
            imageName: "flag_norway",
            rating: 4,
            description: "Norway's coastline is cut by deep fjords that were carved by ancient glaciers. In the north the summer sun barely sets, and in winter you can see the northern lights. I want to take a ferry through the Geirangerfjord."
        ),
        FavoriteItem(
            title: "Italy",
            subtitle: "Rome · Southern Europe",
            imageName: "flag_italy",
            rating: 5,
            description: "Italy has more UNESCO World Heritage Sites than almost any other country. From the ruins of Rome to the canals of Venice, every city feels like a museum. And of course there is the pasta, the pizza and the gelato."
        ),
        FavoriteItem(
            title: "France",
            subtitle: "Paris · Western Europe",
            imageName: "flag_france",
            rating: 4,
            description: "France is one of the most visited countries in the world. Beyond the Eiffel Tower and the Louvre in Paris, it has lavender fields in Provence and castles in the Loire Valley. I want to spend a week just eating croissants and cheese."
        ),
        FavoriteItem(
            title: "Greece",
            subtitle: "Athens · Southern Europe",
            imageName: "flag_greece",
            rating: 4,
            description: "Greece is the birthplace of democracy and the Olympic Games. It has thousands of islands, although only about two hundred of them are inhabited. I want to see the Acropolis in Athens and watch the sunset in Santorini."
        ),
        FavoriteItem(
            title: "United States of America",
            subtitle: "Washington, D.C. · North America",
            imageName: "flag_usa",
            rating: 3,
            description: "The United States stretches from the Atlantic to the Pacific and also includes Alaska and Hawaii. Its national parks, like Yellowstone and the Grand Canyon, are huge and wild. I would love to take a road trip along the coast of California."
        ),
        FavoriteItem(
            title: "Germany",
            subtitle: "Berlin · Central Europe",
            imageName: "flag_germany",
            rating: 3,
            description: "Germany mixes modern cities with medieval old towns and fairy-tale castles like Neuschwanstein. Berlin is full of history, art and street food. I want to visit a Christmas market in December."
        ),
        FavoriteItem(
            title: "Austria",
            subtitle: "Vienna · Central Europe",
            imageName: "flag_austria",
            rating: 4,
            description: "Austria is a land of Alpine lakes, ski resorts and classical music. Mozart, Beethoven and Strauss all lived and worked in Vienna, a city famous for its coffee houses. Salzburg, where Mozart was born, is on my list too."
        ),
        FavoriteItem(
            title: "Netherlands",
            subtitle: "Amsterdam · Western Europe",
            imageName: "flag_netherlands",
            rating: 3,
            description: "The Netherlands is flat, green and full of canals, windmills and tulip fields. About a quarter of the country lies below sea level. The Dutch own more bicycles than there are people, so I would explore Amsterdam by bike."
        ),
        FavoriteItem(
            title: "Sweden",
            subtitle: "Stockholm · Northern Europe",
            imageName: "flag_sweden",
            rating: 3,
            description: "Forests and lakes cover most of Sweden. Stockholm is built on fourteen islands connected by more than fifty bridges. In winter you can sleep in the Icehotel, which is rebuilt from ice every year."
        ),
        FavoriteItem(
            title: "Finland",
            subtitle: "Helsinki · Northern Europe",
            imageName: "flag_finland",
            rating: 2,
            description: "Finland is called the land of a thousand lakes, but it actually has around 188,000 of them. Saunas are a big part of everyday Finnish life. In Lapland you can meet reindeer and see the northern lights."
        ),
        FavoriteItem(
            title: "Denmark",
            subtitle: "Copenhagen · Northern Europe",
            imageName: "flag_denmark",
            rating: 2,
            description: "Denmark is the home of LEGO, which was founded in the town of Billund. Copenhagen is one of the most bike-friendly cities in the world. The Danish word hygge describes a cozy, warm feeling, especially on dark winter evenings."
        ),
        FavoriteItem(
            title: "Ireland",
            subtitle: "Dublin · Western Europe",
            imageName: "flag_ireland",
            rating: 2,
            description: "Ireland is known as the Emerald Isle because of its green hills and fields. The Cliffs of Moher rise more than 200 meters above the Atlantic Ocean. I want to hear live folk music in a Dublin pub."
        ),
        FavoriteItem(
            title: "Belgium",
            subtitle: "Brussels · Western Europe",
            imageName: "flag_belgium",
            rating: 2,
            description: "Belgium is a small country, but it is famous for chocolate, waffles and hundreds of kinds of beer. Bruges has canals and medieval buildings that look like a postcard. Brussels is also home to the main institutions of the European Union."
        ),
        FavoriteItem(
            title: "Vietnam",
            subtitle: "Hanoi · Southeast Asia",
            imageName: "flag_vietnam",
            rating: 4,
            description: "Vietnam stretches along the eastern coast of the Indochina peninsula. Ha Long Bay has nearly two thousand limestone islands rising out of emerald water. I want to eat pho in Hanoi and take a boat through the Mekong Delta."
        ),
        FavoriteItem(
            title: "Thailand",
            subtitle: "Bangkok · Southeast Asia",
            imageName: "flag_thailand",
            rating: 3,
            description: "Thailand is often called the Land of Smiles. Bangkok is full of golden temples, floating markets and amazing street food. The islands in the south have some of the most beautiful beaches in Asia."
        ),
        FavoriteItem(
            title: "Chile",
            subtitle: "Santiago · South America",
            imageName: "flag_chile",
            rating: 3,
            description: "Chile is one of the longest and narrowest countries in the world, about 4,300 kilometers from north to south. It has the Atacama Desert, one of the driest places on Earth, and the glaciers of Patagonia. Easter Island, with its famous moai statues, also belongs to Chile."
        ),
        FavoriteItem(
            title: "Peru",
            subtitle: "Lima · South America",
            imageName: "flag_peru",
            rating: 1,
            description: "Peru is the home of Machu Picchu, the Inca city high in the Andes mountains. It also has part of the Amazon rainforest and Lake Titicaca, which it shares with Bolivia. Peruvian food, like ceviche, is famous around the world."
        )
    ]
}
