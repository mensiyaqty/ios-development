//
//  ViewController.swift
//  FavoritesNavigator
//
//  List screen. Embedded in the navigation controller in Main.storyboard.
//  The Show segue (identifier "showDetail") goes from the prototype cell to the Detail screen.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    /// Both must match the identifiers set in Main.storyboard exactly.
    private let cellIdentifier = "FavoriteCell"
    private let detailSegueIdentifier = "showDetail"

    private let items = FavoritesLibrary.items

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Deselect the tapped row when coming back from the Detail screen.
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
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

    // MARK: - Navigation

    /// Passes only the data (the tapped item) to the Detail screen.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == detailSegueIdentifier,
              let detailViewController = segue.destination as? DetailViewController,
              let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        detailViewController.item = items[indexPath.row]
    }
}
