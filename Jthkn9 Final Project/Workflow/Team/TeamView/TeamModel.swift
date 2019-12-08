//
//  TeamModel.swift
//  Jthkn9's Final Project
//
//  Created by Hoenig, Jackson (UMSL-Student) on 7/24/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation
import struct UIKit.CGFloat

final class TeamModel {
    private var team: Team!
    var count: Int {return team.roster.count}
    init(team: Team){
        self.team = team
    }
    func getPlayer(atIndex: Int) -> Player? {
        return team.roster[atIndex]
    }
    func getTeamName() -> String {
        return team.teamName
    }
    func getLogoName() -> String {
        return team.logo
    }
    
}

