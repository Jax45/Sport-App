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
    var teamId: UUID
    var name: String
    var seasons: [Seasons]
    
    init(playerId: UUID,teamId: UUID, name: String, seasons: [Seasons]) {
        self.playerId = playerId
        self.teamId = teamId
        self.name = name
        self.seasons = seasons
    }
    func withYear(year: Int) -> Seasons{
        return self.seasons.first(where: {$0.year == year}) ?? self.seasons.first ?? Seasons(year: 0, atBat: 0, runs: 0, walks: 0, homeRuns: 0, rBIS: 0, hits: 0)
    }
    func firstName() -> String {
        var partsOfName = name.components(separatedBy: " ")
        let first = partsOfName.removeFirst()
        return first
    }
    func lastName() -> String {
        var partsOfName = name.components(separatedBy: " ")
        _ = partsOfName.removeFirst()
        let last = partsOfName.joined(separator: " ")
        return last
    }
}
