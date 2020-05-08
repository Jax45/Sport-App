//
//  PlayerCreationViewController.swift
//  Jthkn9's Final Project
//
//  Created by jackson on 7/28/19.
//  Copyright © 2019 jackson. All rights reserved.
//
import UIKit
import Foundation


final class PlayerCreationViewController: UIViewController {
    
    @IBOutlet private weak var FirstName: UITextField!
    @IBOutlet private weak var LastName: UITextField!
    @IBOutlet private weak var TeamName: UITextField!
    @IBOutlet private weak var TeamPicker: UIPickerView!
    
    private var model: PlayerCreationModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TeamName.delegate = self
        TeamPicker.dataSource = self
        TeamPicker.delegate = self
        
    }
    
    func setup(model: PlayerCreationModel){
        self.model = model
    }
    
    @IBAction func submitTapped(_ sender: Any) {

        if model.validateInput(first: FirstName?.text, last: LastName?.text, teamName: TeamName?.text) {
            model.savePlayer(first: FirstName.text!, last: LastName.text!, teamId: model.getTeamId(with: TeamName.text!)!)
                navigationController?.popViewController(animated: true)
        }
        else {
            return
        }
    }
}

extension PlayerCreationViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        return model.getTeam(atRow: row)
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        TeamName.text = model.getTeam(atRow: row)
        TeamPicker.isHidden = true
    }
}

extension PlayerCreationViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.getTeamCount()
    }
}
extension PlayerCreationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
