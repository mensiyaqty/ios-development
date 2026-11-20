//
//  FavoriteCell.swift
//  FavoritesNavigator
//
//  List cell: image + title only. Layout is in Main.storyboard.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    /// Fully resets the (possibly reused) cell from one item.
    func configure(with item: FavoriteItem) {
        itemImageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
    }
}
