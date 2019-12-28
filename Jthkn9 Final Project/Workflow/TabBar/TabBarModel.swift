//
//  TabBarModel.swift
//  Jthkn9's Final Project
//
//  Created by jackson on 8/6/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation
final class TabBarModel {
    
    var teams: [Team] = []
    var players: [Player] = []
    let appPersistence: AppPersistence?
    
    init(){
        guard
        let appStorageUrl = FileManager.default.createDirectoryInUserLibrary(atPath: "NWAApp"),
        let persistence = AppPersistence(atUrl: appStorageUrl, withDirectoryName: "teamData")
        
        else {
            Log.error("Could not init persistence objects")
            appPersistence = nil
            return
        }
        appPersistence = persistence
        // Pull from persistence
        let teams = appPersistence!.savedTeams
        let players = appPersistence!.savedPlayers
        
        if teams.isEmpty || players.isEmpty {
        
            //use json
            let teamsFromJson = getTeamsFromJson()
            let playersFromJson = getPlayersFromJson(teams: teamsFromJson)
            
            //save teams to persistence
            //get the roster of id's
            for team in teamsFromJson {
                var playerRoster: [UUID] = []
                for player in team.roster {
                    playerRoster.append(player.playerId)
                }
            
                appPersistence!.saveTeam(team: TeamForPersistance(id: team.id, logo: team.logo, teamName: team.teamName, roster: playerRoster, wins: team.wins, losses: team.losses))
            }
            //save players
            for player in playersFromJson {
            var partsOfName = player.name.components(separatedBy: " ")
            
            let first = partsOfName.removeFirst()
            let last = partsOfName.joined(separator: " ")
            
            appPersistence!.savePlayer(player: PlayerForPersistance(id: player.playerId, firstName: first, lastName: last, teamId: player.teamId, stats: player.seasons))
            }
        
            self.teams = []//teamsFromJson
            self.players = [] //playersFromJson
        } else {
        //convert players and teams
            //let teamsAndPlayers = convertTeamsAndPlayers(teamData: teams, playerData: players, appPersistence: appPersistence)
            self.teams = convertTeamsAndPlayers(teamData: teams, playerData: players, appPersistence: appPersistence!).0
            self.players = convertTeamsAndPlayers(teamData: teams, playerData: players, appPersistence: appPersistence!).1
        }
    }
}
extension TabBarModel {
    
    private func convertTeamsAndPlayers(teamData: [TeamForPersistance], playerData: [PlayerForPersistance], appPersistence: AppPersistence) -> ([Team],[Player]){
        
        var teamList: [Team] = []
        
        let playersFromPersistanceList = appPersistence.savedPlayers
        
        for teamObject in teamData {
            let playerRosterFromPersistance = playersFromPersistanceList.filter {
                teamObject.roster.contains($0.id)
            }
            var playerRoster: [Player] = []
            for playerObject in playerRosterFromPersistance {
                playerRoster.append(Player(playerId: playerObject.id, teamId: playerObject.teamId, name: "\(playerObject.firstName) \(playerObject.lastName)", seasons: playerObject.stats))
            }
            teamList.append(Team(id: teamObject.id, logo: teamObject.logo, teamName: teamObject.teamName, roster: playerRoster, wins: teamObject.wins, losses: teamObject.losses))
        }
        
        //get players from persistance
        var playerList: [Player] = []
        for player in playersFromPersistanceList {
            playerList.append(Player(playerId: player.id, teamId: player.teamId, name: "\(player.firstName) \(player.lastName)", seasons: player.stats))
        }
        
        return (teamList,playerList)
        
    }
    
    private func getTeamsFromJson() -> [Team]{
        return []
        var teamsFromJson: [TeamFromJson]
        var teams: [Team] = []
        teamsFromJson = try! JSONDecoder().decode([TeamFromJson].self, from: jsonReadFile().json)
        
        //convert teams from json to teams
        //delete current teams
        
        for jsonTeam in teamsFromJson {
            var jsonRoster: [Player] = []
            for jsonPlayer in jsonTeam.roster{
                jsonRoster.append(Player(playerId: UUID(), teamId: jsonPlayer.teamId, name: jsonPlayer.name, seasons: jsonPlayer.seasons))
            }
            
            
            teams.append(Team(id: jsonTeam.id, logo: jsonTeam.logo, teamName: jsonTeam.teamName, roster: jsonRoster, wins: jsonTeam.wins, losses: jsonTeam.losses))
        }
        return teams
        
    }
    
    private func getPlayersFromJson(teams: [Team]) -> [Player] {
        var playerList: [Player] = []
        for team in teams {
            playerList.append(contentsOf: team.roster)
        }
        return playerList
    }
}

    

