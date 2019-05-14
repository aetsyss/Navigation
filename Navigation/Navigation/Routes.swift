//
//  Routes.swift
//  Navigation
//
//  Created by Aleksei Tsyss on 14/05/2019.
//  Copyright © 2019 Aleksei Tsyss. All rights reserved.
//

import UIKit.UIViewController

// MARK: - Profile
protocol CanOpenProfile {
    func openProfile(viewModel: Profile)
}

extension CanOpenProfile where Self: UIViewController {
    func openProfile(viewModel: Profile) {
        let vc = ProfileTableViewController.instantiate(with: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Settings
protocol CanOpenSettings {
    func openSettings()
}

extension CanOpenSettings where Self: UIViewController {
    func openSettings() {
        let vc = SettingsTableViewController.instantiate(with: ())
        navigationController?.pushViewController(vc, animated: true)
    }
}
