# Travel Wishlist 🌍

**Student:** Yerassyl Maratov
**Theme:** Countries — my travel wishlist

## About the app
Travel Wishlist is a UIKit app that lists 20 countries I want to visit. The list sits inside a `UINavigationController` with a large title, and each row shows the country's flag and name.

Tapping a row opens a **Detail** screen through a **Show** segue. It shows:
- a large flag
- the country name and its capital and region
- a rating of 0–5 SF Symbol stars for how much I want to go
- a short description

The Back button or an edge swipe returns to the list, and the row is deselected.

**Built in `Main.storyboard`:** every screen, the navigation controller, the segue, the navigation bar title and all Auto Layout.

**Swift contains only:**
- the data model: the `FavoriteItem` struct and `FavoritesLibrary`
- the table view data source
- `prepare(for:sender:)`, which passes the tapped item to `DetailViewController.item`
- filling the outlets from data

**Icon and launch screen:** the app has a custom App Icon. `LaunchScreen.storyboard` shows the icon art and the app name, centered with constraints on the system background color, so it also works in Dark Mode.

## Screenshots

| List | Detail | Launch Screen | Home Screen |
|---|---|---|---|
| ![List](screenshots/list.png) | ![Detail](screenshots/detail.png) | ![Launch](screenshots/launch.png) | ![Icon](screenshots/home.png) |
