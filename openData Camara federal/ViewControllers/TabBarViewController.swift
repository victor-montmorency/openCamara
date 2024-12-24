//
//  TabBarVC.swift
//  openData Camara federal
//
//  Created by victor mont-morency on 16/12/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        
        // For iOS 13 and later
        if #available(iOS 13.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            
            tabBarAppearance.backgroundColor = UIColor.secondarySystemBackground
            tabBarAppearance.stackedLayoutAppearance.normal.iconColor = .systemGray2
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.systemGray2]
            tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.systemGray
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.systemGray]

            tabBar.standardAppearance = tabBarAppearance
            
            // For iOS 15 and later
            if #available(iOS 15.0, *) {
                tabBar.standardAppearance = tabBarAppearance

                tabBar.scrollEdgeAppearance = tabBarAppearance
            }
        }
    }
    
private func setupTabs() {
    
    let home = self.createNav(title: "Home", image: UIImage(systemName: "house")!, vc: homeViewController())
    let pesquisar = self.createNav(title: "Pesquisar", image: UIImage(systemName: "magnifyingglass")!, vc: searchViewController())
    let favorites = self.createNav(title: "Favoritos", image: UIImage(systemName: "star")!, vc: favoritesViewController())

    
    self.setViewControllers([home, pesquisar, favorites], animated: true)
    }

    
    private func createNav(title: String, image: UIImage, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.navigationBar.isTranslucent = false
        return nav
    }
    
}
