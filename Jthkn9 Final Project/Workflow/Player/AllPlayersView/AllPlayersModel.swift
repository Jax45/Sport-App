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
    
    func filter(filter: String){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let currentYear = Int(dateFormatter.string(from: Date()))
        //check lowercase
        
        switch filter {
        case "First":
            players.sort(by: { $0.firstName().lowercased() < $1.firstName().lowercased() })
        case "Last":
            players.sort(by: { $0.lastName().lowercased() < $1.lastName().lowercased()})
        case "Hits":
            players.sort(by: {$0.withYear(year: currentYear!).hits > $1.withYear(year: currentYear!).hits})
        case "Walks":
            players.sort(by: {$0.withYear(year: currentYear!).walks > $1.withYear(year: currentYear!).walks})
        case "HR's":
            players.sort(by: {$0.withYear(year: currentYear!).homeRuns > $1.withYear(year: currentYear!).homeRuns})
        case "RBI's":
            players.sort(by: {$0.withYear(year: currentYear!).rBIS > $1.withYear(year: currentYear!).rBIS})
        case "OBP":
            players.sort(by: {$0.withYear(year: currentYear!).OBP > $1.withYear(year: currentYear!).OBP})
        case "AtBat":
            players.sort(by: {$0.withYear(year: currentYear!).atBat > $1.withYear(year: currentYear!).atBat})
        case "BA":
            players.sort(by: {$0.withYear(year: currentYear!).BA > $1.withYear(year: currentYear!).BA})
        case "Runs":
            players.sort(by: {$0.withYear(year: currentYear!).runs > $1.withYear(year: currentYear!).runs})

        default:
            print("Filter error.")
        }
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

    func getTeamTupleArray() -> [(Int, String)] {
        var tupleArray: [(Int,String)] = []
        for team in teams {
            tupleArray.append((team.id, team.teamName))
        }
        return tupleArray
    }
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
    func addPlayer(player: Player) {
        var partsOfName = player.name.components(separatedBy: " ")
        
        let first = partsOfName.removeFirst()
        let last = partsOfName.joined(separator: " ")
        persistence?.addPlayerToTeam(player: PlayerForPersistance(id: player.playerId, firstName: first, lastName: last, teamId: player.teamId, stats: player.seasons))
        
        //add local
        players.append(player)
    }
}
