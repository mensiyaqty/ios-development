# Setup: Music Player lab

## 1. Create the project
In Xcode, choose **File → New → Project → iOS → App**.
- Product Name: `MusicPlayer`
- Interface: **Storyboard**
- Language: **Swift**

## 2. Copy the files
Close Xcode. In Finder, open the inner `MusicPlayer/` folder (the one with `ViewController.swift`) and copy in these files, choosing **Replace** when asked:
- `ViewController.swift`
- `Track.swift` (new)
- `Base.lproj/Main.storyboard`
- the whole `Assets.xcassets` folder. It has 10 covers, the **AppIcon** and the AccentColor.
- the `Audio/` folder with the 10 `.mp3` files

Also copy `README.md` and `.gitignore` into the **outer** folder, the one that has `MusicPlayer.xcodeproj`. The `.gitignore` file is hidden in Finder; press **⌘⇧.** to show it.

## 3. Check Target Membership for the audio
- **Xcode 16 or later:** files in the folder are added to the target automatically. To check, click one `.mp3` and look at **File Inspector → Target Membership → MusicPlayer**. It should be ticked.
- **Older Xcode:**
  1. Drag the `Audio` folder into the project navigator.
  2. Tick **Copy items if needed** and **Add to targets: MusicPlayer**.
  3. Use the same steps to add `Track.swift` if it doesn't show up.

## 4. Remove the orange layout warnings
Open `Main.storyboard`, select the View Controller, and choose **Editor → Resolve Auto Layout Issues → Update Frames** under *All Views in View Controller*.
- This only moves the frames to match the constraints. It doesn't change the constraints themselves.
- After this, the Document Outline should show no red or yellow arrows.

## 5. Display name and run
1. Click the target, open **General → Display Name**, and enter `Music Player`.
2. Run the app on **iPhone SE (3rd generation)** and **iPhone 16 Pro Max**.
3. Take a screenshot on each with **⌘S** in the Simulator.
4. Record the demo with **File → Record Screen** in the Simulator. Show:
   - play and pause
   - next and previous
   - wraparound: press Previous on the first track to jump to "City Lights", then press Next to return to "Neon Drive"
5. Save the screenshots and the recording in a `screenshots/` folder.

If the app icon doesn't appear on the Home Screen, delete the app from the Simulator and run it again.

## How the stack views decide the frames (for the defense)

**Root stack**
- Settings: axis **vertical**, alignment **fill**, distribution **fill**, spacing **32**.
- *Fill* alignment makes every child as wide as the stack, which is the screen width minus 2 × 20 pt.
- The stack's height is the sum of its children's heights plus the spacing.

**Cover image**
- It gets its width from the stack. The **1:1 aspect ratio** constraint then makes its height equal to its width, so it's square on every screen size.

**Labels stack**
- Settings: vertical, fill, spacing 6.
- The two labels take their natural text height and the full width, with the text centered.

**Controls stack**
- Settings: axis **horizontal**, distribution **fill equally**, alignment **center**, spacing 16.
- The three buttons get equal widths: (width − 2 × 16) / 3.
- The buttons are centered vertically, so the bigger Play button lines up with the smaller ones.

**Constraints:** there are only 4.
- Root stack: leading 20 and trailing 20 to the Safe Area, and Center Y to the Safe Area.
- Cover: aspect ratio 1:1.

**Code:** `ViewController.swift` only connects outlets and actions and plays audio. It has no `NSLayoutConstraint`, anchors, `frame =` or `addSubview`.
