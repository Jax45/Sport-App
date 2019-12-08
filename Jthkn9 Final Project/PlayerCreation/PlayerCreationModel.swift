//
//  playerCreationModel.swift
//  Jthkn9's Final Project
//
//  Created by jackson on 7/26/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation

protocol TeamModelDelegate: class {
    func save(player: Player)
}

final class PlayerCreationModel {
    //key is the TeamId, and value is the name of the team.
    private(set) var teams: [(Int, String)]
    
    private weak var delegate: TeamModelDelegate?
    
    init(teams: [(Int, String)], delegate: TeamModelDelegate?) {
        //self.player = player
        self.delegate = delegate
        self.teams = teams
    }
}

extension PlayerCreationModel {
    func validName(name: String) -> Bool{
         //lastName.count > 1, lastName.count < 15, firstName.count > 1, firstName.count < 15,
    
        if name.isEmpty || name.count > 15 {
            return false
        }
        let regEx = "[a-zA-Z]*"
        let validation = NSPredicate(format: "SELF MATCHES %@", regEx)
        return validation.evaluate(with: name)
    }
    
    func validateInput(first: String?, last: String?, teamName: String?) -> Bool{
        guard let firstName = first, let lastName = last, let team = teamName else {return false}
        //now check that names are valid
        if !validName(name: firstName) || !validName(name: lastName) {
            return false
        }
        //now check that it is a valid team name
        if getTeamId(with: team) == -1{
            return false
        }
        return true
    }
    
    func savePlayer(first: String, last: String, teamId: Int) {
        let player = Player(playerId: UUID(), teamId: teamId, name: "\(first) \(last)", seasons: [])
        delegate?.save(player: player)
    }
    
    func getTeam(atRow: Int) -> String {
        return teams[atRow].1
    }
    
    func getTeamCount() -> Int {
        return teams.count
    }
    
    func getTeamId(with name: String) -> Int{
        return teams.first { $0.1 == name}?.0 ?? -1
    }
    
    func getTeamNames() -> [String] {
        var teamNames: [String] = []
        for team in teams{
            teamNames.append(team.1)
            
        }
        return teamNames
    }
}
