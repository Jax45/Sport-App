//
//  TeamListTableViewCell.swift
//  Jthkn9's Final Project
//
//  Created by jackson on 7/21/19.
//  Copyright © 2019 jackson. All rights reserved.
//
import UIKit
import Foundation
final class TeamListTableViewCell: UITableViewCell {
    @IBOutlet private weak var logo: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var recordLabel: UILabel!
    
    private(set) var team: Team!
    
    func setup(with team: Team) {
        self.team = team
        nameLabel.text = team.teamName
        logo.image = UIImage(named: team.logo)
        recordLabel.text = "\(team.wins)-\(team.losses)"
        print(team.logo)
        

    }
}
