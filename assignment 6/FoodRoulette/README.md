# Food Roulette 🎲

Lab 6 · Favorites Roulette. This is a single-screen iOS app that shows a random card from my 10 favorite foods.

- **Category:** Food (Kyrgyz and Korean dishes)
- **Tech:** UIKit, Storyboard, Swift. No Auto Layout: the screens use frames and autoresizing masks.
- **Data:** an array of the `Favorite` struct (`Favorite.swift`). Each favorite has an image in `Assets.xcassets`, a title and a description.
- **Behavior:** each tap on **Spin the Roulette** flips the card and shows a random favorite. The same favorite is never shown twice in a row. The code has no force unwraps except the `@IBOutlet` declarations.

## Screenshots

| Launch screen | Main screen | Home Screen icon |
|---|---|---|
| ![Launch](screenshots/launch.png) | ![Main](screenshots/main.png) | ![Icon](screenshots/home.png) |
