import Foundation

protocol AppPersistenceInterface {
    var savedTeams: [TeamForPersistance] { get }
    var savedPlayers: [PlayerForPersistance] { get }

    func saveTeam(team: TeamForPersistance)
    func savePlayer(player: PlayerForPersistance)
    func addPlayerToTeam(player: PlayerForPersistance)
    func deleteTeam(team: TeamForPersistance)
    func deletePlayer(player: PlayerForPersistance)
    func deleteAllData()
}

final class AppPersistence: FileStoragePersistence, AppPersistenceInterface {
    let directoryUrl: URL
    let fileType: String = "json"
    
    init?(atUrl baseUrl: URL, withDirectoryName name: String) {
        guard let directoryUrl = FileManager.default.createDirectory(atUrl: baseUrl, appendingPath: name) else { return nil }
        self.directoryUrl = directoryUrl
    }
    
    var savedTeams: [TeamForPersistance] {
        
        return names.compactMap {
            guard let teamData = read(fileWithId: $0) else { return nil }
            
            return try? JSONDecoder().decode(TeamForPersistance.self, from: teamData)
        }
    }
    var savedPlayers: [PlayerForPersistance] {
        
        return names.compactMap {
            guard let playerData = read(fileWithId: $0) else { return nil }
            
            return try? JSONDecoder().decode(PlayerForPersistance.self, from: playerData)
        }
    }
    
    func saveTeam(team: TeamForPersistance){
        save(object: team, withId: "team\(team.id)")
    }
    func savePlayer(player: PlayerForPersistance) {
        save(object: player, withId: "player\(player.id)")
    }
   // func addTeam(team: Team){
        
  //  }
    func addPlayerToTeam(player: PlayerForPersistance) {
        guard let teamData = read(fileWithId: "team\(player.teamId)") else {return}
        var teamfromPersistance = try? JSONDecoder().decode(TeamForPersistance.self, from: teamData)
        //add the value to roster
        teamfromPersistance?.roster.append(player.id)
        
        save(object: teamfromPersistance, withId: "team\(teamfromPersistance!.id)")
        
        save(object: player, withId: "player\(player.id)")
    }
    func deleteTeam(team: TeamForPersistance) {
        removeFile(withName: "team\(team.id)")
    }
    func deletePlayer(player: PlayerForPersistance){
        removeFile(withName: "player\(player.id)")
        
        //delete team reference
        guard let teamData = read(fileWithId: "team\(player.teamId)") else {return}
        var teamfromPersistance = try? JSONDecoder().decode(TeamForPersistance.self, from: teamData)
        //add the value to roster
        teamfromPersistance?.roster.removeAll(where: {$0 == player.id})
        
    }
    
    func deleteAllData() {
        removeAllDataInDirectory()
    }
}
