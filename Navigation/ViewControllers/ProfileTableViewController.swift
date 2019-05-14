//
//  ProfileTableViewController.swift
//  Navigation
//
//  Created by Aleksei Tsyss on 14/05/2019.
//  Copyright © 2019 Aleksei Tsyss. All rights reserved.
//

import UIKit

final class ProfileTableViewController: UITableViewController, Instantiatable, CanOpenSettings {

    @IBOutlet weak var nameLabel: UILabel!

    var viewModel: Profile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let viewModel = viewModel else {
            fatalError("viewModel isn't supposed to be nil")
        }

        nameLabel.text = viewModel.name
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            openSettings()
        }
    }

}
