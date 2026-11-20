//
//  ViewController.swift
//  FoodRoulette
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets (connected in Main.storyboard)
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var spinButton: UIButton!

    // MARK: - Data
    private let favorites: [Favorite] = Favorite.all
    private var currentIndex: Int?          // nil = initial state, nothing shown yet

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        styleViews()
        showInitialState()
    }

    // MARK: - Actions
    @IBAction func spinTapped(_ sender: UIButton) {
        guard let favorite = nextRandomFavorite() else { return }
        display(favorite)
    }

    // MARK: - Logic

    /// Picks a random favorite that is different from the one currently on screen.
    private func nextRandomFavorite() -> Favorite? {
        let candidates = favorites.indices.filter { $0 != currentIndex }
        guard let index = candidates.randomElement() else { return nil }
        currentIndex = index
        return favorites[index]
    }

    // MARK: - UI

    private func showInitialState() {
        favoriteImageView.image = UIImage(named: "intro")
        titleLabel.text = "Ready to spin?"
        descriptionLabel.text = "Tap the button below to get a random dish from my top 10 favorite foods."
    }

    /// Updates image, title and description together, with a card-flip animation.
    private func display(_ favorite: Favorite) {
        UIView.transition(with: cardView,
                          duration: 0.4,
                          options: .transitionFlipFromRight) {
            self.favoriteImageView.image = UIImage(named: favorite.imageName)
            self.titleLabel.text = favorite.title
            self.descriptionLabel.text = favorite.description
        }
    }

    private func styleViews() {
        // Card: rounded corners, image clipped to the card
        cardView.layer.cornerRadius = 24
        cardView.layer.borderWidth = 1
        cardView.layer.borderColor = UIColor(red: 0.91, green: 0.34, blue: 0.16, alpha: 0.25).cgColor
        cardView.clipsToBounds = true

        // Image: keep aspect ratio (no stretching), crop overflow
        favoriteImageView.contentMode = .scaleAspectFill
        favoriteImageView.clipsToBounds = true

        // Labels: never cut text off
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.6

        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.minimumScaleFactor = 0.7

        // Button
        spinButton.layer.cornerRadius = 16
        spinButton.clipsToBounds = true
    }
}
