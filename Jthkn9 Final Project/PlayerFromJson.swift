//
//  playerFromJson.swift
//  Jthkn9's Final Project
//
//  Created by jackson on 7/30/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation

struct PlayerFromJson: Codable {
    var teamId: UUID
    var name: String
    var seasons: [Seasons]
    
    init(teamId: UUID, name: String, seasons: [Seasons]) {
        self.teamId = teamId
        self.name = name
        self.seasons = seasons
    }
    
}
