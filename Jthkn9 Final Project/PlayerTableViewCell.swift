//
//  PlayerTableViewCell.swift
//  Jthkn9's Final Project
//
//  Created by jackson on 7/25/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation
import UIKit

//set up stat outlets


final class PlayerTableViewCell: UITableViewCell {
    @IBOutlet private weak var firstName: UILabel!
    @IBOutlet private weak var lastName: UILabel!
    @IBOutlet weak var hits: UILabel!
    @IBOutlet weak var atBat: UILabel!
    @IBOutlet weak var runs: UILabel!
    @IBOutlet weak var walks: UILabel!
    @IBOutlet weak var rbis: UILabel!
    @IBOutlet weak var homeRuns: UILabel!
    
    @IBOutlet weak var onBase: UILabel!
    @IBOutlet weak var batAvg: UILabel!
    
    private(set) var player: Player!
    //private let dateFormatter = DateFormatter().dateFormat = "yyyy"
    //private let year = Int(DateFormatter().string(from: Date()))
    func setup(with player: Player) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year = Int(dateFormatter.string(from: Date()))
        self.player = player
        
        var partsOfName = player.name.components(separatedBy: " ")
        
        let first = partsOfName.removeFirst()
        let last = partsOfName.joined(separator: " ")
        
        firstName.text = first
        lastName.text = last
        
        let stats = player.seasons.first(where: {$0.year == year})
        
        hits.text = "Hits: \(stats?.hits ?? 0)"
        atBat.text = "at Bats: \(stats?.atBat ?? 0)"
        runs.text = "Runs: \(stats?.runs ?? 0)"
        walks.text = "Walks: \(stats?.walks ?? 0)"
        rbis.text = "RBI's: \(stats?.rBIS ?? 0)"
        homeRuns.text = "HR's: \(stats?.homeRuns ?? 0)"
        
        let ba = String(format: "%.2f", stats?.BA ?? 0.00)
        let obp = String(format: "%.2f", stats?.OBP ?? 0.00)
        
        onBase.text = "OBP: \(obp)"
        batAvg.text = "BA: \(ba)"
    }
    func setup(with seasons: Seasons) {
        
        firstName.text = "\(seasons.year)"
        lastName.text = ""
        
        //let stats = player.seasons.first(where: {$0.year == year})
        
        hits.text = "Hits: \(seasons.hits )"
        atBat.text = "at Bats: \(seasons.atBat )"
        runs.text = "Runs: \(seasons.runs )"
        walks.text = "Walks: \(seasons.walks )"
        rbis.text = "RBI's: \(seasons.rBIS )"
        homeRuns.text = "HR's: \(seasons.homeRuns )"
        
        let ba = String(format: "%.2f", seasons.BA )
        let obp = String(format: "%.2f", seasons.OBP )
        
        onBase.text = "OBP: \(obp)"
        batAvg.text = "BA: \(ba)"
    }
    
}
