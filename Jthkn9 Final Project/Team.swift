//
//  Team.swift
//  Jthkn9's Final Project
//
//  Created by jackson on 7/23/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation


struct Team: Codable {
    let id: UUID
    var logo: String
    var teamName: String
    var roster: [Player]
    var wins: Int
    var losses: Int
}
