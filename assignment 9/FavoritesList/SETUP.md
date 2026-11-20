# Setup: Favorites List lab

## 1. Create the project
In Xcode, choose **File → New → Project → iOS → App**.
- Product Name: `FavoritesList`
- Interface: **Storyboard**
- Language: **Swift**

## 2. Copy the files
Close Xcode. In Finder, open the inner `FavoritesList/` folder (the one with `ViewController.swift`) and copy in these files, choosing **Replace** when asked:
- `ViewController.swift`
- `FavoriteCell.swift` (new)
- `FavoriteItem.swift` (new)
- `Base.lproj/Main.storyboard`
- the whole `Assets.xcassets` folder. It has 20 flags, the **AppIcon** and the AccentColor.

Also copy `README.md` and `.gitignore` into the **outer** folder, the one with `FavoritesList.xcodeproj`. The `.gitignore` file is hidden in Finder; press **⌘⇧.** to show it.

**Xcode 16 or later** picks up the new Swift files automatically. On **older Xcode**, add them yourself:
1. Right-click the `FavoritesList` group and choose **Add Files…**.
2. Select `FavoriteCell.swift` and `FavoriteItem.swift`.
3. Tick the app target.

## 3. Remove the orange layout warnings
Open `Main.storyboard`, select the **View Controller** scene, and choose **Editor → Resolve Auto Layout Issues → Update Frames** under *All Views in View Controller*.
- The storyboard was written by hand, so a few frames may be a point or two off. That shows up as orange "misplaced" warnings.
- This only moves the frames to match the constraints. It doesn't change the constraints themselves.
- After this, the Document Outline should show no red or yellow arrows.

## 4. Display name and run
1. Click the target, open **General → Display Name**, and enter `Travel Wishlist`.
2. Run the app on **iPhone SE (3rd generation)** and **iPhone 16 Pro Max**.
3. Take a screenshot on each with **⌘S** in the Simulator.
4. Record yourself scrolling the whole list with **File → Record Screen** in the Simulator.
5. Save the screenshots and the recording in a `screenshots/` folder.

If the app icon doesn't appear on the Home Screen, delete the app from the Simulator and run it again.

---

## How the layout works (for the defense)

**Storyboard structure**
```
Navigation Controller (large title "Travel Wishlist")
└─ View Controller
   └─ Table View  ── pinned to Safe Area: top, leading, trailing, bottom = 0
      └─ Prototype cell  (Class: FavoriteCell, Identifier: FavoriteCell)
         └─ Content View
            ├─ Item Image (UIImageView, Aspect Fit)
            └─ Text Stack (vertical, fill, spacing 6)
               ├─ Title (Headline, Lines = 0)
               ├─ Subtitle (Subheadline, Lines = 0)
               └─ Rating Stack (horizontal, fill, spacing 2)
                  ├─ Star 1 … Star 5 (SF Symbol star.fill / star, 14 pt, orange)
                  └─ Spacer (UIView, hugging 1, so the stars stay on the left)
```

**Cell constraints:** there are only 9, all on the image and the outer stack.

| View | Constraint |
|---|---|
| Image | Width = 96, Height = 64 (fixed size) |
| Image | Leading = 16 |
| Image | Center Y = Content View Center Y |
| Image | Top ≥ 12, which also keeps the bottom ≥ 12 because the image is centered |
| Text Stack | Leading = Image.trailing + 12 |
| Text Stack | Trailing = 16 |
| Text Stack | Top = 12 |
| Text Stack | Bottom = 12, **priority 999** |

**Why it works**
- The stack is pinned from the top edge to the bottom edge of the content view, so the cell's height follows its content (self-sizing: Row Height = Automatic).
- If the text is shorter than the image, the priority-999 bottom constraint gives way. The cell then stays at least 64 + 24 = 88 pt tall instead of logging "Unable to simultaneously satisfy constraints".
- A long title wraps (Lines = 0) inside the stack. The stack sits between the image and the right edge, so text never overlaps the image or goes off screen.

**Code**
- `ViewController` returns `items.count` rows and dequeues cells with `dequeueReusableCell(withIdentifier: "FavoriteCell", for:)`, cast to `FavoriteCell`.
- `configure(with:)` sets every view (image, both labels, all 5 stars) each time a cell is reused, so old data never stays on screen.
