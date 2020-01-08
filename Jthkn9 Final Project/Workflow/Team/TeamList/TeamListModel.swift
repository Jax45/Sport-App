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
    private var teamsFromScaledrone: [Team] = []
    let rowHeight: CGFloat = 64.0
    var count: Int {return teams.count}
    private var delegate: TeamListModelDelegate?
    private var persistence: AppPersistenceInterface?
    private var teamsFromJson: [TeamFromJson] = []
    init(persistence: AppPersistenceInterface?, teams: [Team]) {
        self.teams = teams
        self.persistence = persistence
        teamService = TeamService(onRecievedMessage: {[weak self] json in
        //print(json)
            do{
            self?.teamsFromScaledrone = try JSONDecoder().decode([Team].self, from: json.data(using: .utf8)!)
            }catch {
                print("could not parse json")
            }
        })
        teamService.connect()
    }
}

extension TeamListModel {
    func refreashMessageHistory(){
        teamService = TeamService(onRecievedMessage: {[weak self] json in
        //print(json)
            do{
            self?.teamsFromScaledrone = try JSONDecoder().decode([Team].self, from: json.data(using: .utf8)!)
            }catch {
                print("could not parse json")
            }
        })
        teamService.connect()
    }
    func setDelegate(delegate: TeamListModelDelegate){
        self.delegate = delegate
    }
    func getAllTeams() -> [Team]{
        return teams
    }
    func send(msg: String){
//        teamService = TeamService(onRecievedMessage: {json in print("Sending data")})
//        teamService.connect()
        teamService.sendMessage(msg)
        //refresh the message history
        //teamService.disconnect()
        //        refreashMessageHistory()

    }
    
    func importTeamsFromJson(){
        refreashMessageHistory()

        teams = teamsFromScaledrone
                //clear old persistence and replace it with new data from json
                self.persistence?.deleteAllData()

                for team in self.teams {
                    //get player id's
                    var playerList: [UUID] = []
                    for playerObject in team.roster {
                        
                        var partsOfName = playerObject.name.components(separatedBy: " ")
                        let first = partsOfName.removeFirst()
                        let last = partsOfName.joined(separator: " ")
                        
                        self.persistence?.savePlayer(player: PlayerForPersistance(id: playerObject.playerId, firstName: first, lastName: last, teamId: playerObject.teamId, stats: playerObject.seasons))
                        playerList.append(playerObject.playerId)
                    }
                    self.persistence?.saveTeam(team: TeamForPersistance(id: team.id, logo: team.logo, teamName: team.teamName, roster: playerList, wins: team.wins, losses: team.losses))
                }
                print("team set from json")
                self.delegate?.dataRefreshed()
            
        
        
    }
    
    func addTeam(name: String, logo: String){
        teams.append(Team(id: UUID(), logo: logo, teamName: name, roster: [], wins: 0, losses: 0))
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
    
    func getTeamDictionary() -> [UUID : String] {
        var dictionary: [UUID : String] = [:]
        for team in teams{
            dictionary[team.id] = team.teamName
        }
        return dictionary
    }
    func getTeamTupleArray() -> [(UUID, String)] {
        var tupleArray: [(UUID,String)] = []
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
        var selectedTeam: Team
        for team in teams{
            if team.id == player.teamId {
                
                var roster = team.roster
                roster.append(player)
                selectedTeam = Team(id: team.id, logo: team.logo, teamName: team.teamName, roster: roster, wins: team.wins, losses: team.losses)
                teams.removeAll(where:{ $0.id == selectedTeam.id})
                teams.append(selectedTeam)
            }
        }
        
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
            var rosterIds: [UUID] = []
            for player in teamToSave.roster{
                rosterIds.append(player.playerId)
            }
            
            persistence?.saveTeam(team: TeamForPersistance(id: teamToSave.id, logo: teamToSave.logo, teamName: teamToSave.teamName, roster: rosterIds, wins: teamToSave.wins, losses: teamToSave.losses))
        }
        else{
            teams.append(teamToSave)
            persistence?.saveTeam(team: TeamForPersistance(id: teamToSave.id, logo: teamToSave.logo, teamName: teamToSave.teamName, roster: [], wins: teamToSave.wins, losses: teamToSave.losses))
        }
    }
    func deleteTeam(atRow: Int){
        let team = teams[atRow]
        persistence?.deleteTeam(team: TeamForPersistance(id: team.id, logo: team.logo, teamName: team.teamName, roster: [], wins: team.wins, losses: team.losses))
        teams.remove(at: atRow)
    }
}
