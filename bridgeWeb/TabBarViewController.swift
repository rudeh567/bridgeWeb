//
//  TabBarViewController.swift
//  bridgeWeb
//
//  Created by yeoboya on 2021/10/29.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let loginView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "login") as! ViewController
        let loginBarItem = UITabBarItem(title: "Login", image: nil, selectedImage: nil)
        
        loginView.tabBarItem = loginBarItem
        
        let signupView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signup") as! SignUpViewController
        let signupBarItem = UITabBarItem(title: "SignUp", image: nil, selectedImage: nil)
        
        signupView.tabBarItem = signupBarItem
        
        self.viewControllers = [loginView, signupView]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
}
