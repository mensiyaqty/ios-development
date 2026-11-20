# Setup: Favorites Navigator lab

## 1. Create the project
In Xcode, choose **File → New → Project → iOS → App**.
- Product Name: `FavoritesNavigator`
- Interface: **Storyboard**
- Language: **Swift**

## 2. Copy the files
Close Xcode. In Finder, open the inner `FavoritesNavigator/` folder (the one with `ViewController.swift`) and copy in these files, choosing **Replace** when asked:
- `ViewController.swift` (the list screen)
- `DetailViewController.swift`, `FavoriteCell.swift`, `FavoriteItem.swift` (all new)
- `Base.lproj/Main.storyboard` and `Base.lproj/LaunchScreen.storyboard`
- the whole `Assets.xcassets` folder. It has 20 flags, the **AppIcon**, the **LaunchLogo** and the AccentColor.

Also copy `README.md` and `.gitignore` into the **outer** folder, the one with the `.xcodeproj`. The `.gitignore` file is hidden in Finder; press **⌘⇧.** to show it.

**Xcode 16 or later** picks up the new Swift files automatically. On **older Xcode**, add them yourself:
1. Right-click the group and choose **Add Files…**.
2. Select the three new Swift files.
3. Tick the app target.

## 3. Remove the orange layout warnings
Open `Main.storyboard`. For **each** of the List and Detail scenes:
1. Select the scene's view controller.
2. Choose **Editor → Resolve Auto Layout Issues → Update Frames** under *All Views in View Controller*.

Do the same in `LaunchScreen.storyboard`.

- The storyboards were written by hand, so a few frames may be a point or two off. That shows up as orange "misplaced" warnings.
- This only moves the frames to match the constraints. It doesn't change the constraints themselves.
- After this, the Document Outline should show no red or yellow arrows.

## 4. Check the target settings
1. Open **General → App Icons and Launch Screen**. **Launch Screen File** should say `LaunchScreen`; it's set by default in new projects. **App Icon** should be `AppIcon`.
2. Open **General → Display Name** and enter `Travel Wishlist`.

## 5. Test and take the screenshots
1. Run the app on **iPhone SE (3rd generation)** and **iPhone 16 Pro Max**.
2. Test Dark Mode: in the Simulator, choose **Features → Toggle Appearance**, or press **⇧⌘A**.
3. Tap a row, then go back. Try both the Back button and a swipe from the left edge. The row should be deselected.
4. Take 4 screenshots with **⌘S** and save them in `screenshots/`:
   - `list.png`
   - `detail.png`
   - `launch.png` (take this the moment the app starts)
   - `home.png` (Home Screen with the icon; press **⇧⌘H** to get there)

If the launch screen or icon doesn't update, iOS is using a cached copy. Delete the app from the Simulator and run it again.

## 6. Push to GitHub
The lab says no zip archives, so push the whole project:
```bash
cd path/to/FavoritesNavigator
git init && git add . && git commit -m "Favorites Navigator lab"
git branch -M main
git remote add origin <your-repo-url>
git push -u origin main
```

---

## How it works (for the defense)

**Storyboard flow**
```
Navigation Controller (initial, Prefers Large Titles ✓)
  └─ root → List (ViewController)  title "Travel Wishlist", Large Title: Always
               └─ Table View pinned to Safe Area (4 constraints)
                  └─ Prototype cell  Class: FavoriteCell, Identifier: FavoriteCell, Accessory: Disclosure
                       └─ Show segue, identifier "showDetail" → Detail (DetailViewController)
                                                               Large Title: Never (small title)
```

**Passing data**

`ViewController.prepare(for:sender:)` does these steps in order:
1. Checks `segue.identifier == "showDetail"`.
2. Casts `segue.destination as? DetailViewController`.
3. Reads `tableView.indexPathForSelectedRow`.
4. Sets `detail.item = items[row]`.

Only data is passed. The Detail screen fills its own outlets and sets its navigation title in `viewDidLoad`.

**Deselect on return:** in `viewWillAppear`, if `indexPathForSelectedRow` isn't nil, the list calls `deselectRow(at:animated:)`.

**List cell constraints**

| View | Constraints |
|---|---|
| Flag image | 60 × 40 fixed. Leading 16. Center Y. Top ≥ 12, which keeps the cell at least 64 pt tall. A Top = 12 constraint at **priority 250** pulls the cell down to that minimum. |
| Title | Leading = image + 12. Trailing 8. Center Y. Top ≥ 12. Lines = 0, so a long title wraps and the cell grows. |

**Detail screen**
- **Scroll view:** pinned to the Safe Area. Its Content View is pinned to the *Content Layout Guide*, and its width equals the *Frame Layout Guide*.
- **Large image:** top, leading and trailing 16. A **3:2 aspect ratio** sets the height. Content Mode is **Aspect Fit**, so the flag keeps its proportions. It sits on a rounded card background.
- **Info stack:** vertical, spacing 10. It holds the Title (Title 1), the Subtitle, the Rating stack (5 SF Symbol stars plus a spacer) and the Description (Body, **Lines = 0**). Constraints: top = image + 20, leading and trailing 16, bottom 24.

**Shared style:** both screens use the same system text styles (Headline / Title 1, Subheadline, Body), the same 16 pt margins, the orange star color, and system background colors that work in Dark Mode.
