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
    @IBOutlet weak var profileView: ProfileView!
    
    private let defaults = UserDefaults.standard
    private var iconView: IconView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //NameTextField.text = .randomName
        if let data = defaults.object(forKey: "userProfile") as? Data {
            let profile = try? PropertyListDecoder().decode(UserProfile.self, from: data)
            NameTextField.text = profile?.name
            GreenSlider.setValue(profile!.green, animated: false)
            BlueSlider.setValue(profile!.blue, animated: false)
            RedSlider.setValue(profile!.red, animated: false)
            iconView = IconView(frame: .zero, red: profile!.red, green: profile!.green, blue: profile!.blue)
        }
        else{
            let components = UIColor.random.cgColor.components;
            guard let red = components?[0],
                let green = components?[1],
                let blue = components?[2] else{return}
            GreenSlider.setValue(Float(green), animated: false)
            BlueSlider.setValue(Float(blue), animated: false)
            RedSlider.setValue(Float(red), animated: false)
            iconView = IconView(frame: .zero, red: Float(red), green: Float(green), blue: Float(blue))
        }
        profileView.addSubview(iconView)

        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func SliderChanged(_ sender: Any) {
        profileView.newColors(red: RedSlider.value, green: GreenSlider.value, blue: BlueSlider.value)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MessageViewController{
            var name = NameTextField.text!
            if NameTextField.text == ""{
                name = String.randomName
                NameTextField.text = name
                
            }

            let profile = UserProfile(name: name, red: RedSlider!.value, green: GreenSlider!.value, blue: BlueSlider!.value)
            defaults.set(try? PropertyListEncoder().encode(profile), forKey: "userProfile")
            vc.setupProfile(member: Member(name: name, color: UIColor(red: CGFloat(RedSlider!.value), green: CGFloat(GreenSlider!.value), blue: CGFloat(BlueSlider!.value), alpha: 1)))
        }
    }
    

 

}
