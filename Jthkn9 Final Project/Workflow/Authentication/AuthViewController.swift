//
//  AuthViewController.swift
//  Jthkn9 Final Project
//
//  Created by user159466 on 12/27/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    @IBOutlet weak var label: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    static func instanceOfParent() -> UINavigationController {
        let navigationController = UINavigationController.with(storyboardName: "Auth")
        _ = navigationController.rootViewController(asType: AuthViewController.self)
        //viewController.setup(model: model)
        return navigationController
    }
    @IBAction func LoginPressed(_ sender: Any) {
        if let text = label.text{
            let defaults = UserDefaults.standard
            if text == "PatrickIsAFreakingPro16485246854315$%#&%$*"{
                //Admin
                defaults.set(2, forKey: "Auth")
            }
            else if text == "NWA4ever123!"{
                //user
                defaults.set(1, forKey: "Auth")
            }
            else{
                //guest
                defaults.set(0, forKey: "Auth")
            }
        }
    }
    


}
