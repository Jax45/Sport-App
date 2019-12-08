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
    
    private var model: TeamModel!
    
    func setup(model: TeamModel){
        self.model = model
    }
}

extension TeamViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = model.getTeamName()
        logo.image = UIImage(named: model.getLogoName())
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
