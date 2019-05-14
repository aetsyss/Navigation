//
//  UsersTableViewController.swift
//  Navigation
//
//  Created by Aleksei Tsyss on 14/05/2019.
//  Copyright © 2019 Aleksei Tsyss. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController, CanOpenProfile, CanOpenSettings {

    private lazy var profiles: [Profile] = [
        Profile(name: "Alice"),
        Profile(name: "Bob"),
        Profile(name: "Vladimir Vladimirovich")
    ]

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let profile = profiles[indexPath.row]
            openProfile(viewModel: profile)
        } else {
            openSettings()
        }
    }

}
