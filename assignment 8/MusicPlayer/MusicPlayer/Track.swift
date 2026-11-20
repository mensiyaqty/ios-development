//
//  Track.swift
//  MusicPlayer
//

import Foundation

/// One song in the player.
struct Track {
    let title: String
    let artist: String
    let fileName: String          // audio file name in the bundle, without extension
    let coverImageName: String    // image set name in Assets.xcassets
    let fileExtension: String = "mp3"
}

/// The whole track list, defined in one place.
enum TrackLibrary {
    static let tracks: [Track] = [
        Track(title: "Neon Drive",    artist: "Night Nomad",       fileName: "neon_drive",    coverImageName: "cover_neon_drive"),
        Track(title: "Morning Tea",   artist: "Soft Steppe",       fileName: "morning_tea",   coverImageName: "cover_morning_tea"),
        Track(title: "Han River",     artist: "Seoul Echo",        fileName: "han_river",     coverImageName: "cover_han_river"),
        Track(title: "Issyk-Kul",     artist: "Tien Shan Trio",    fileName: "issyk_kul",     coverImageName: "cover_issyk_kul"),
        Track(title: "Pixel Hearts",  artist: "8-Bit Kid",         fileName: "pixel_hearts",  coverImageName: "cover_pixel_hearts"),
        Track(title: "Late Library",  artist: "Quiet Pages",       fileName: "late_library",  coverImageName: "cover_late_library"),
        Track(title: "Subway Line 2", artist: "Line 2 Collective", fileName: "subway_line_2", coverImageName: "cover_subway_line_2"),
        Track(title: "Mountain Air",  artist: "Ala-Too Sound",     fileName: "mountain_air",  coverImageName: "cover_mountain_air"),
        Track(title: "First Snow",    artist: "Winter Keys",       fileName: "first_snow",    coverImageName: "cover_first_snow"),
        Track(title: "City Lights",   artist: "Metro Glow",        fileName: "city_lights",   coverImageName: "cover_city_lights")
    ]
}
