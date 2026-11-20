//
//  DetailViewController.swift
//  FavoritesNavigator
//
//  Detail screen. Layout is in Main.storyboard; this class only fills its own outlets.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!

    /// Set by the list screen in prepare(for:sender:).
    var item: FavoriteItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let item = item else { return }

        navigationItem.title = item.title
        itemImageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        descriptionLabel.text = item.description

        let rating = min(max(item.rating, 0), 5)
        let stars: [UIImageView] = [star1, star2, star3, star4, star5]
        for (index, star) in stars.enumerated() {
            star.image = UIImage(systemName: index < rating ? "star.fill" : "star")
        }
    }
}
