//
//  SeasonModel.swift
//  Jthkn9 Final Project
//
//  Created by user159466 on 12/10/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation
class PlayerSelectModel {
    private var player: Player
    init(player: Player) {
        self.player = player
    }
    func addSeason(season: Seasons){
        player.seasons.append(season)
    }
    func updateSeason(season: Seasons){
        player.seasons.remove(at: player.seasons.firstIndex(where: {$0.year == season.year})!)
        player.seasons.append(season)
    }
    func setPlayer(player: Player){
        self.player = player
    }
    func getPlayer() -> Player{
        return player
    }
    func getCount() -> Int {
        return player.seasons.count
    }
    func getSeason(index: Int) -> Seasons {
        return player.seasons[index]
    }
    func getYears() ->[Int]{
        var years: [Int] = []
        for season in player.seasons{
            years.append(season.year)
        }
        return years
    }
}
