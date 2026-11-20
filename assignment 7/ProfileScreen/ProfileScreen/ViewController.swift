//
//  ViewController.swift
//  ProfileScreen
//
//  Assignment 7 · Variant A (Profile)
//  All views and constraints are in Main.storyboard.
//  This file only fills in data: no frames, no constraints, no anchors.
//

import UIKit

struct Profile {
    let name: String
    let username: String
    let posts: String
    let followers: String
    let following: String
    let about: String
    let avatarImageName: String
}

class ViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!

    // Long-text test name from the assignment
    private let profile = Profile(
        name: "Maximilian Alexander von Habsburg",
        username: "@max.habsburg",
        posts: "128",
        followers: "12.4K",
        following: "312",
        about: "Product designer and amateur historian based in Vienna. I write about old maps, "
             + "typography and the stories behind everyday objects. Coffee first, then pixels. "
             + "Currently learning iOS development with UIKit and Auto Layout, one constraint at a time.",
        avatarImageName: "avatar"
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        fill(with: profile)
    }

    private func fill(with profile: Profile) {
        avatarImageView.image = UIImage(named: profile.avatarImageName)
        nameLabel.text = profile.name
        usernameLabel.text = profile.username
        postsLabel.text = profile.posts
        followersLabel.text = profile.followers
        followingLabel.text = profile.following
        aboutLabel.text = profile.about
    }
}
