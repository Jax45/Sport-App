//
//  Player.swift
//  Jthkn9's Final Project
//
//  Created by jackson on 7/21/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation

struct Player: Codable {
    let playerId: UUID
    var teamId: Int
    var name: String
    var seasons: [Seasons]
    
    init(playerId: UUID,teamId: Int, name: String, seasons: [Seasons]) {
        self.playerId = playerId
        self.teamId = teamId
        self.name = name
        self.seasons = seasons
    }
    func firstName() -> String {
        var partsOfName = name.components(separatedBy: " ")
        let first = partsOfName.removeFirst()
        return first
    }
    func lastName() -> String {
        let partsOfName = name.components(separatedBy: " ")
        let last = partsOfName.joined(separator: " ")
        return last
    }
}
