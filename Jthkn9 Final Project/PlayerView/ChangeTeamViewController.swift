//
//  ChangeTeamViewController.swift
//  Jthkn9 Final Project
//
//  Created by user159466 on 1/8/20.
//  Copyright © 2020 jackson. All rights reserved.
//

import UIKit

class ChangeTeamViewController: UIViewController {

    
    @IBOutlet weak var TeamName: UITextField!
    weak var delegate: ChangeTeamDelegate?
    
    @IBOutlet weak var TeamPicker: UIPickerView!
    private var model: PlayerSelectModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func setup(del: ChangeTeamDelegate,model: PlayerSelectModel){
        delegate = del
        self.model = model
    }

     @IBAction func ChangedTeamPressed(_ sender: Any) {
        guard let id = model.getTeam(name: TeamName.text!) else {return}
        delegate?.teamChanged(teamId: id)
        dismiss(animated: true, completion: nil)
     }
     
     @IBAction func CancelChangeTeam(_ sender: Any) {
         dismiss(animated: true, completion: nil)
     }
    


}

extension ChangeTeamViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return model.getTeamName(atRow: row)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        TeamName.text = model.getTeamName(atRow: row)
        //TeamPicker.isHidden = true
    }
}

extension ChangeTeamViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.getTeamCount()
    }
}

extension ChangeTeamViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == TeamName {
            TeamPicker.isHidden = false
            TeamPicker.selectRow(0, inComponent: 0, animated: false)
            return false
        }
        TeamPicker.isHidden = true
        return true
    }
}
