# Travel Wishlist 🌍

Lab: Favorites List (UITableView & Custom Cells). This app shows the **20 countries I want to visit** in a `UITableView` with a custom cell. Each row has the country's flag, its name, its capital and region, and a rating from 0 to 5 stars for how much I want to go.

## How it's built
- **Data:** a `FavoriteItem` struct (`title`, `subtitle`, `imageName`, `rating`). All 20 items are in one place, `FavoritesLibrary`.
- **Images:** every item has its own flag image in `Assets.xcassets`, drawn to that country's official proportions.
- **Cell:** `FavoriteCell` is a `UITableViewCell` subclass in its own file. It has only `@IBOutlet`s and one `configure(with:)` method. It's designed as a prototype cell inside the table view in `Main.storyboard`, with the reuse identifier **FavoriteCell**.
- **Cell layout:**
  - the flag image is a fixed 96 × 64
  - a vertical stack holds the title, the subtitle and a horizontal stack of 5 SF Symbol stars (`star.fill` / `star`)
  - all Auto Layout is in the storyboard, with no layout code in Swift
- **Data source:** `ViewController` implements `UITableViewDataSource`, returns one row per item, and dequeues cells with `dequeueReusableCell(withIdentifier:for:)` cast to `FavoriteCell`.
- **Table view:** fills the Safe Area. Rows size themselves to their content, so long titles wrap instead of overlapping the image.

## Screenshots

| iPhone SE (3rd gen) | iPhone 16 Pro Max |
|---|---|
| ![SE](screenshots/iphone-se.png) | ![Pro Max](screenshots/iphone-16-pro-max.png) |

## Demo
Screen recording scrolling through the whole list: `screenshots/demo.mp4` (or a link)
