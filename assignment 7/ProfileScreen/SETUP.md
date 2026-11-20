# Assignment 7 · Variant A (Profile): setup

## Put it into Xcode

1. Create a new project: **File → New → Project → iOS → App**.
   - Product Name: `ProfileScreen`
   - Interface: **Storyboard**
   - Language: **Swift**
2. Close Xcode. In Finder, open the project's inner `ProfileScreen/` folder and copy in these files:
   - `ViewController.swift`: replace the old one.
   - `Base.lproj/Main.storyboard`: replace the old one.
   - `Assets.xcassets/avatar.imageset`: copy only this folder into your existing `Assets.xcassets`. Keep `AppIcon` and `AccentColor`.
3. Reopen the project and open `Main.storyboard`.
4. Select the View Controller. Choose **Editor → Resolve Auto Layout Issues → Update Frames** under *All Views in View Controller*.
   - The storyboard was written by hand, so a few label frames may be a point or two off. That shows up as orange "misplaced" warnings.
   - This step moves the frames to match the constraints. It doesn't change any constraints.
   - The Document Outline should then show no red or orange arrows.
5. Run the app on **iPhone SE (3rd generation)** and on **iPhone 16 Pro Max**.
   - The long name "Maximilian Alexander von Habsburg" is already in the data, so the long-text test runs every time.
   - Check the console: there should be no "Unable to simultaneously satisfy constraints" messages.

## How the layout works (for the grading / your explanation)

**Structure (no UIStackView):** Root view → Scroll View → Content View, then:
- Avatar
- Name
- Username
- Stats, which holds 3 columns and 2 dividers
- Follow and Message buttons
- About title and About text

**Scroll view**
- It's pinned to the safe area on all four sides, so content stays inside the safe area.
- The Content View is pinned to the scroll view's *Content Layout Guide* on all four sides.
- The Content View has **Equal Widths** with the *Frame Layout Guide*, so it scrolls vertically only.
- The page can scroll on the small iPhone SE screen, so the unlimited About text never gets clipped.

| Element | Constraints |
|---|---|
| Avatar | Width 96, Height 96, Center X, Top 24. Corner radius 48 (User Defined Runtime Attribute `layer.cornerRadius`) plus Clip to Bounds, which makes it a circle. |
| Name | Leading 16, Trailing 16, Top = Avatar.bottom + 16. Lines = **2**, centered, word wrap. |
| Username | Leading 16, Trailing 16, Top = Name.bottom + 4 |
| Stats container | Leading 16, Trailing 16, Top = Username.bottom + 24 |
| Columns | Chain: Column1 → Divider1 → Column2 → Divider2 → Column3. Each is pinned to the next, and the first and last are pinned to the container's leading and trailing edges. Column2 and Column3 have **Equal Widths** to Column1. Each column's top and bottom equal the container's. |
| Dividers | Width 1, 12 pt inset from the top and bottom |
| Column labels | Center X. Value Top 12, Caption Top = Value.bottom + 2, Caption Bottom 12. Leading ≥ 4, and the font auto-shrinks, so a big number can't overflow. |
| Follow | Leading 16, Top = Stats.bottom + 24, Height **48** |
| Message | Leading = Follow.trailing + **12**, Trailing 16, **Equal Widths** to Follow, Height **48**, Top = Follow.top |
| About title | Leading 16, Trailing 16, Top = Follow.bottom + 24 |
| About text | Leading 16, Trailing 16, Top = Title.bottom + 8, **Lines = 0**, Bottom = Content View bottom − 24 |

The side margins are 16 pt everywhere.

`ViewController.swift` only puts data into the outlets: the image, the texts and the numbers. It doesn't set any frames, constraints or anchors.
