# How to put this into Xcode

1. In Xcode, choose **File → New → Project → iOS → App**.
   - Product Name: `FoodRoulette`
   - Interface: **Storyboard**
   - Language: **Swift**
2. Close Xcode. In Finder, open the new project's inner `FoodRoulette/` folder (the one that has `ViewController.swift`). Copy these from this zip into it, and choose **Replace** when Finder asks:
   - `ViewController.swift`
   - `Favorite.swift` (a new file)
   - `Base.lproj/Main.storyboard`
   - `Base.lproj/LaunchScreen.storyboard`
   - the whole `Assets.xcassets` folder (replace the old one)
3. Reopen the project.
   - On Xcode 16 or later, the new files show up automatically.
   - On older Xcode, `Favorite.swift` may not appear. Right-click the `FoodRoulette` group, choose **Add Files…**, and add it with your target ticked.
4. Click the target, then open **General → Identity → Display Name**. Enter `Food Roulette`.
5. Run the app on the **iPhone 16** (or 15) Simulator. The layout was drawn at 393×852.
6. Take the three screenshots with **⌘S** in the Simulator:
   - the launch screen
   - the main screen
   - the Home Screen with the icon (press **⇧⌘H** to get to the Home Screen)

   Put them in a `screenshots/` folder named `launch.png`, `main.png` and `home.png`.
7. Push the project to your own Git repository and submit the link:

   ```bash
   cd path/to/FoodRoulette
   git init && git add . && git commit -m "Lab 6: Favorites Roulette"
   git remote add origin <your-repo-url>
   git push -u origin main
   ```

## Tips

- **Launch screen didn't update?** iOS caches it. Delete the app from the Simulator, or use **Device → Erase All Content and Settings**, then run the app again.
- **Real food photos:** the food images are generated placeholders. To use real photos, drag a photo onto the matching image set in `Assets.xcassets` and keep the same name (for example `plov`).
- **Changing the foods:** edit the array in `Favorite.swift`. Keep exactly 10 items.
