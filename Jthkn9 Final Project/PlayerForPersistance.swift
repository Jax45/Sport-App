//
//  PlayerForPersistence.swift
//  Jthkn9's Final Project
//
//  Created by jackson on 7/30/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation
struct PlayerForPersistance: Codable {
    let id: UUID
    var firstName: String
    var lastName: String
    var teamId: UUID
    var stats: [Seasons] = []
}

