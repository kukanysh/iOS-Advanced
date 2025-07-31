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

        let homeVC = UIHostingController(rootView: MainPageView())
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "line"), tag: 0)
        
        let medStatsVC = UIHostingController(rootView: MedStatsView())
        medStatsVC.tabBarItem = UITabBarItem(title: "Stats", image: UIImage(named: "grommet"), tag: 1)

        let profileVC = UIHostingController(rootView: ProfileView())
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 2)
        
        let settingsVC = UIHostingController(rootView: MoreView())
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), tag: 3)
        
        // Remove blur and set solid background for tab bar
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .blueish // Change to your desired color
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }

        viewControllers = [homeVC, medStatsVC, profileVC, settingsVC]
    }
}
