//
//  TeamForPersistance.swift
//  Jthkn9's Final Project
//
//  Created by jackson on 7/30/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation
struct TeamForPersistance: Codable{
    let id: Int
    var logo: String
    var teamName: String
    var roster: [UUID]
    var wins: Int
    var losses: Int
}
