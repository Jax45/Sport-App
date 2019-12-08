import Foundation
import struct UIKit.CGFloat

protocol AllPlayersModelDelegate: class {
    func dataRefreshed()
}

final class AllPlayersModel{
    
    private var teams: [Team] = []
    private var players: [Player] = []
    let rowHeight: CGFloat = 64.0
    var count: Int {return players.count}
    private var delegate: AllPlayersModelDelegate?
    private var persistence: AppPersistenceInterface?
    
    init(persistence: AppPersistenceInterface?, teams: [Team], players: [Player]) {
        self.persistence = persistence
        self.players = players
        self.teams = teams
        
        
    }
    
}

extension AllPlayersModel {
    func getPlayer(atIndex: Int) -> Player{
        return players[atIndex]
    }
    
    func importDataFromPersistance() {
        
        guard let teamData = persistence?.savedTeams else {return}
            teams.removeAll()
        
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
        //save players
        players.removeAll()
        for player in playerList{
            players.append(Player(playerId: player.id, teamId: player.teamId, name: "\(player.firstName) \(player.lastName)", seasons: player.stats))
        }
        
    }
    
    func deletePlayer(player: Player){
        //delete from persistance and get persistance
        var partsOfName = player.name.components(separatedBy: " ")
        
        let first = partsOfName.removeFirst()
        let last = partsOfName.joined(separator: " ")
        
        persistence?.deletePlayer(player: PlayerForPersistance(id: player.playerId, firstName: first, lastName: last, teamId: player.teamId, stats: player.seasons))
        //delete local
        players.removeAll(where: {$0.playerId == player.playerId})
    }
}
