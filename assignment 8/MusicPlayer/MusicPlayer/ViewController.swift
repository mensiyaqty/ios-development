//
//  ViewController.swift
//  MusicPlayer
//
//  All layout lives in Main.storyboard (UIStackViews + a few constraints).
//  This file has no layout code: no constraints, anchors, frames or addSubview.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!

    // MARK: - State (one place for everything the screen shows)
    private let tracks = TrackLibrary.tracks
    private var currentIndex = 0
    private var isPlaying = false

    /// Stored as a property so the player stays alive as long as the screen does.
    private var player: AVAudioPlayer?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAudioSession()
        loadTrack(at: currentIndex)
        updateUI()
    }

    // MARK: - Actions
    @IBAction func playPauseTapped(_ sender: UIButton) {
        if isPlaying {
            player?.pause()
            isPlaying = false
        } else {
            if player == nil { loadTrack(at: currentIndex) }
            isPlaying = player?.play() ?? false
        }
        updateUI()
    }

    @IBAction func nextTapped(_ sender: UIButton) {
        changeTrack(by: 1)
    }

    @IBAction func previousTapped(_ sender: UIButton) {
        changeTrack(by: -1)
    }

    // MARK: - Playback

    /// Moves to another track, wraps around the list and keeps the play state.
    private func changeTrack(by step: Int) {
        guard !tracks.isEmpty else { return }
        let wasPlaying = isPlaying
        currentIndex = (currentIndex + step + tracks.count) % tracks.count
        loadTrack(at: currentIndex)
        isPlaying = wasPlaying ? (player?.play() ?? false) : false
        updateUI()
    }

    /// Creates a new AVAudioPlayer for the track. Never crashes on a missing/broken file.
    private func loadTrack(at index: Int) {
        player?.stop()
        player = nil

        let track = tracks[index]
        guard let url = Bundle.main.url(forResource: track.fileName, withExtension: track.fileExtension) else {
            print("⚠️ Audio file not found in bundle: \(track.fileName).\(track.fileExtension) — check Target Membership.")
            return
        }
        do {
            let newPlayer = try AVAudioPlayer(contentsOf: url)
            newPlayer.delegate = self
            newPlayer.prepareToPlay()
            player = newPlayer
        } catch {
            print("⚠️ Could not load \(track.fileName).\(track.fileExtension): \(error.localizedDescription)")
        }
    }

    private func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("⚠️ Audio session error: \(error.localizedDescription)")
        }
    }

    // MARK: - UI

    /// Refreshes the whole screen from the current state.
    private func updateUI() {
        let track = tracks[currentIndex]
        coverImageView.image = UIImage(named: track.coverImageName)
        titleLabel.text = track.title
        artistLabel.text = track.artist

        let symbol = isPlaying ? "pause.fill" : "play.fill"
        playPauseButton.setImage(UIImage(systemName: symbol), for: .normal)
        playPauseButton.accessibilityLabel = isPlaying ? "Pause" : "Play"
    }
}

// MARK: - AVAudioPlayerDelegate
extension ViewController: AVAudioPlayerDelegate {
    /// When a track ends, the next one starts automatically.
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        changeTrack(by: 1)   // isPlaying is still true, so the next track plays
    }
}
