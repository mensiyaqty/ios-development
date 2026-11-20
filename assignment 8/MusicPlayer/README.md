# Music Player 🎵

Lab: Music Player (UIStackView & Auto Layout). This is a single-screen UIKit music player. It shows a track cover, title and artist, and has Previous / Play-Pause / Next controls that play 10 audio files bundled with the app.

## Features
- **Layout:** built only in `Main.storyboard` from 3 nested `UIStackView`s:
  - a vertical root stack
  - a vertical stack with the title and artist labels
  - a horizontal stack with the controls
- **Constraints:** only 4 in total. The root stack has leading and trailing 20 pt to the Safe Area and is centered vertically. The cover has a 1:1 aspect ratio.
- **Track data:** a `Track` struct (`title`, `artist`, `fileName`, `coverImageName`). All 10 tracks are listed in one place, `TrackLibrary`.
- **Playback:** uses `AVAudioPlayer` and `Bundle.main.url(forResource:withExtension:)`.
- **Play/Pause:** switches the icon between `play.fill` and `pause.fill`.
- **Next / Previous:** keep the current play state, and the list wraps around at both ends.
- **Auto-advance:** the next track starts when one finishes, using `AVAudioPlayerDelegate`.
- **Missing or broken files:** a missing file or a failed `try` prints a clear message instead of crashing.

## Screenshots

| iPhone SE (3rd gen) | iPhone 16 Pro Max |
|---|---|
| ![SE](screenshots/iphone-se.png) | ![Pro Max](screenshots/iphone-16-pro-max.png) |

## Demo
Screen recording: `screenshots/demo.mp4` (or a link)

## Music
All 10 tracks are short original instrumentals made for this project. They are royalty-free and each file is about 0.5 MB.
