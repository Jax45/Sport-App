//
//  TeamViewController.swift
//  Jthkn9's Final Project
//
//  Created by Hoenig, Jackson (UMSL-Student) on 7/24/19.
//  Copyright © 2019 jackson. All rights reserved.
//
import UIKit
import Foundation
final class TeamViewController: UIViewController {
    
    @IBOutlet private weak var logo: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var logoField: UITextField!
    @IBOutlet weak var WinField: UITextField!
    @IBOutlet weak var LossField: UITextField!
    private var model: TeamModel!
    private var delegate: TeamViewEditDelegate!
    
    func setup(model: TeamModel,delegate: TeamViewEditDelegate){
        self.model = model
        self.delegate = delegate
    }
    @IBAction func UpdatePressed(_ sender: Any) {
        if NameField.text!.isEmpty || WinField.text!.isEmpty || LossField.text!.isEmpty || logoField.text!.isEmpty {
            return
        }
        guard let wins = Int(WinField.text!), let losses = Int(LossField.text!) else {return}
        
        delegate.update(team: Team(id: model.getUUID(), logo: logoField.text!, teamName: NameField.text!, roster: model.getRoster(), wins: wins, losses: losses))
        navigationController?.popViewController(animated: true)
        
        
    }
}

extension TeamViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = model.getTeamName()
        logo.image = UIImage(named: model.getLogoName()) ?? UIImage(named: "NWA")
        NameField.text = model.getTeamName()
        WinField.text = model.getWins()
        LossField.text = model.getLosses()
        logoField.text = model.getLogoName()
    }
}

extension TeamViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell")! as! PlayerTableViewCell
        cell.setup(with: (model?.getPlayer(atIndex: indexPath.row))!)
        return cell
    }
}

extension TeamViewController: UITableViewDelegate {
    func dataRefreshed() {
        tableView.reloadData()
    }
}
