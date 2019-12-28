//
//  TeamUpdateViewController.swift
//  Jthkn9 Final Project
//
//  Created by user159466 on 12/27/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import UIKit

class TeamUpdateViewController: UIViewController {

    var delegate: TeamUpdateDelegate!
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var LogoField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
 
    @IBAction func SubmitPressed(_ sender: Any) {
        delegate?.submit(name: NameField.text!, logo: LogoField.text!)
        navigationController?.popViewController(animated: true)
    }
    
}
