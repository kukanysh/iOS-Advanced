//
//  MainTabBarController.swift
//  Medeasy
//
//  Created by Куаныш Спандияр on 12.05.2025.
//

import Foundation
import UIKit
import SwiftUI

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = UIHostingController(rootView: HomeView())
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)

        let profileVC = UIHostingController(rootView: ProfileView())
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)

        viewControllers = [homeVC, profileVC]
    }
}
