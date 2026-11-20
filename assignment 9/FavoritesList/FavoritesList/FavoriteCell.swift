//
//  FavoriteCell.swift
//  FavoritesList
//
//  Custom prototype cell. Only @IBOutlets + one method that fills the cell.
//  All layout is in Main.storyboard — no layout code here.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!

    /// Fully resets the (possibly reused) cell from one item.
    func configure(with item: FavoriteItem) {
        itemImageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle

        let rating = min(max(item.rating, 0), 5)
        let stars: [UIImageView] = [star1, star2, star3, star4, star5]
        for (index, star) in stars.enumerated() {
            star.image = UIImage(systemName: index < rating ? "star.fill" : "star")
        }
        accessibilityLabel = "\(item.title), \(item.subtitle), rating \(rating) of 5"
    }
}
