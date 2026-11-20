//
//  ViewController.swift
//  FavoritesList
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    /// Must match the Identifier of the prototype cell in Main.storyboard exactly.
    private let cellIdentifier = "FavoriteCell"
    private let items = FavoritesLibrary.items

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? FavoriteCell else {
            fatalError("Prototype cell '\(cellIdentifier)' is missing or its class is not FavoriteCell.")
        }
        cell.configure(with: items[indexPath.row])
        return cell
    }
}
