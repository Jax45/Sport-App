//
//  ChooseRoomViewController.swift
//  Jthkn9 Final Project
//
//  Created by user159466 on 12/6/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var RedSlider: UISlider!
    @IBOutlet weak var GreenSlider: UISlider!
    @IBOutlet weak var BlueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //NameTextField.text = .randomName
        let components = UIColor.random.cgColor.components;
        guard let red = components?[0],
            let green = components?[1],
            let blue = components?[2] else{return}
        GreenSlider.setValue(Float(green), animated: false)
        BlueSlider.setValue(Float(blue), animated: false)
        RedSlider.setValue(Float(red), animated: false)

        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MessageViewController{
            var name = NameTextField.text ?? String.randomName
            if NameTextField.text == ""{
                name = String.randomName
            }
            vc.setupProfile(member: Member(name: name, color: UIColor(red: CGFloat(RedSlider!.value), green: CGFloat(GreenSlider!.value), blue: CGFloat(BlueSlider!.value), alpha: 1)))
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
