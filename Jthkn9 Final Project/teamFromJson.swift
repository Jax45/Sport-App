//
//  teamFromJson.swift
//  Jthkn9's Final Project
//
//  Created by jackson on 7/30/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation


struct TeamFromJson: Codable {
    let id: UUID
    var logo: String
    var teamName: String
    var roster: [PlayerFromJson]
    var wins: Int
    var losses: Int
}
