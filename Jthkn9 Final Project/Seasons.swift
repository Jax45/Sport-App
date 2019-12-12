//
//  Seasons.swift
//  Jthkn9's Final Project
//
//  Created by jackson on 7/23/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation

struct Seasons: Codable {
    let year: Int
    var atBat: Int
    var runs: Int
    var walks: Int
    var homeRuns: Int
    var rBIS: Int
    var hits: Int
    
    var OBP: Double {return (Double(hits + walks) / Double(atBat + walks))}
    var BA: Double {return (Double(hits) / Double(atBat))}
    
    
}

