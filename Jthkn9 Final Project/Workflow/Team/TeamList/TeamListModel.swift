//
//  TeamListModel.swift
//  Jthkn9's Final Project
//
//  Created by jackson on 7/21/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation
import struct UIKit.CGFloat

protocol TeamListModelDelegate: class {
    func dataRefreshed()
}


final class TeamListModel{
    private var teamService: TeamService!
    private var teams: [Team] = []
    let rowHeight: CGFloat = 64.0
    var count: Int {return teams.count}
    private var delegate: TeamListModelDelegate?
    private var persistence: AppPersistenceInterface?
    private var teamsFromJson: [TeamFromJson] = []
    init(persistence: AppPersistenceInterface?, teams: [Team]) {
        self.teams = teams
        self.persistence = persistence
        teamService = TeamService(onRecievedMessage: {
          [weak self] json in
          print(json)
            self?.teamsFromJson = try! JSONDecoder().decode([TeamFromJson].self, from: json.data(using: .utf8)!)
        })
    }
}

extension TeamListModel {
    
    func send(msg: String){
        teamService.sendMessage(msg)
    }
    
    func importTeamsFromJson(){
        //var teamsFromJson: [TeamFromJson] = []
        //var jsonString = ""
        //teamService.connect()
//        teamService = TeamService(onRecievedMessage: {
//          [weak self] json in
//          print(json)
//            teamsFromJson = try! JSONDecoder().decode([TeamFromJson].self, from: json.data(using: .utf8)!)
//        })

        //teamService.connect()

        
        
        //convert teamsfrom json to teams
        //delete current teams
        teams.removeAll()
        for jsonTeam in teamsFromJson {
            var jsonRoster: [Player] = []
            for jsonPlayer in jsonTeam.roster{
                jsonRoster.append(Player(playerId: UUID(), teamId: jsonPlayer.teamId, name: jsonPlayer.name, seasons: jsonPlayer.seasons))
            }
            teams.append(Team(id: jsonTeam.id, logo: jsonTeam.logo, teamName: jsonTeam.teamName, roster: jsonRoster, wins: jsonTeam.wins, losses: jsonTeam.losses))
        }
        //clear old persistence and replace it with new data from json
        persistence?.deleteAllData()

        for team in teams {
            //get player id's
            var playerList: [UUID] = []
            for playerObject in team.roster {
                
                var partsOfName = playerObject.name.components(separatedBy: " ")
                let first = partsOfName.removeFirst()
                let last = partsOfName.joined(separator: " ")
                
                persistence?.savePlayer(player: PlayerForPersistance(id: playerObject.playerId, firstName: first, lastName: last, teamId: playerObject.teamId, stats: playerObject.seasons))
                playerList.append(playerObject.playerId)
            }
            persistence?.saveTeam(team: TeamForPersistance(id: team.id, logo: team.logo, teamName: team.teamName, roster: playerList, wins: team.wins, losses: team.losses))
        }
    }
    
    func importTeamsFromPersistance() {
        if let teamData = persistence?.savedTeams  {
            var teamList: [Team] = []
            let playerList = persistence?.savedPlayers ?? []
            for teamObject in teamData {
                
                let playerRosterFromPersistance = playerList.filter {
                    teamObject.roster.contains($0.id)
                }
                var playerRoster: [Player] = []
                for playerObject in playerRosterFromPersistance {
                    playerRoster.append(Player(playerId: playerObject.id, teamId: playerObject.teamId, name: "\(playerObject.firstName) \(playerObject.lastName)", seasons: playerObject.stats))
                }
                teamList.append(Team(id: teamObject.id, logo: teamObject.logo, teamName: teamObject.teamName, roster: playerRoster, wins: teamObject.wins, losses: teamObject.losses))
            }
            teams = teamList
        }
    }
    func connectToScaledrone(){
         teamService.connect()
    }
    func team(atIndex index: Int) -> Team? {
        //return team at index index.
        return teams[index]
    }
    
    func getTeamName(index: Int) -> String{
        return teams[index].teamName
    }
    
    func getLogoString(index: Int) -> String{
        return teams[index].logo
    }
    
    func getTeamAtIndex(atIndex: Int) -> Team? {
        return teams[atIndex]
    }
    
    func getTeamDictionary() -> [Int : String] {
        var dictionary: [Int : String] = [:]
        for team in teams{
            dictionary[team.id] = team.teamName
        }
        return dictionary
    }
    func getTeamTupleArray() -> [(Int, String)] {
        var tupleArray: [(Int,String)] = []
        for team in teams {
            tupleArray.append((team.id, team.teamName))
        }
        return tupleArray
    }
    
    func save(player: Player) {
        //save to persistence
        var partsOfName = player.name.components(separatedBy: " ")
        let first = partsOfName.removeFirst()
        let last = partsOfName.joined(separator: " ")
        persistence?.addPlayerToTeam(player: PlayerForPersistance(id: player.playerId, firstName: first, lastName: last, teamId: player.teamId, stats: player.seasons))
        //save to local
        var selectedTeam: Team = Team(id: 0, logo: "", teamName: "", roster: [], wins: 0, losses: 0)
        for team in teams{
            if team.id == player.teamId {
                
                var roster = team.roster
                roster.append(player)
                selectedTeam = Team(id: team.id, logo: team.logo, teamName: team.teamName, roster: roster, wins: team.wins, losses: team.losses)
            }
        }
        teams.removeAll(where:{ $0.id == selectedTeam.id})
        teams.append(selectedTeam)
    }
    
    func save(teamToSave: Team) {
        //only append team to list if it does not exist
        var isExistingTeam: Bool = false
        for team in teams{
            if team.id == teamToSave.id {
                //save the id
                isExistingTeam = true
                break;
            }
        }
        if isExistingTeam {
            //if this is true we know we will find the index. hence we can bang
            let existingIndex = teams.firstIndex(where: {return $0.id == teamToSave.id})
            teams[existingIndex!].self = teamToSave
        }
        else{
            teams.append(teamToSave)
        }
    }
}
