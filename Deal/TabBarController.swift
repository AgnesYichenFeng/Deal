//
//  TabBarController.swift
//  Deal
//
//  Created by Nina Xie on 4/25/19.
//  Copyright © 2019 F(X). All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    let red = UIColor(named: "Red")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "Deal"
        delegate = self
        self.tabBar.tintColor = red
        
        let VC1 = DealViewController()
        VC1.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Home"), tag: 0)
        
        let VC2 = PostViewController()
        VC2.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Post"), tag: 1)
//        VC2.delegate = DealViewController() // ??
        
        let VC3 = UserViewController()
        VC3.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "User"), tag: 2)
        
        viewControllers = [VC1, VC2, VC3]
        
        guard let tabs = tabBar.items else { return }
        for tab in tabs {
            tab.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        }
        
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.barTintColor = red
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)]
        navigationBarAppearace.tintColor = .white
        let bounds = navigationBarAppearace.bounds
        navigationBarAppearace.frame = CGRect (x: 0, y: 0, width: bounds.width, height:100)
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if selectedIndex == 1 {
            title = nil
            let postController = UINavigationController(rootViewController: PostViewController())
            self.present(postController, animated: true, completion: {
                self.selectedIndex = 0
                self.title = self.selectedViewController?.navigationItem.title
            })}
        else {
            title = selectedViewController?.navigationItem.title
        }
    }
}
