//
//  PlayerViewController.swift
//  Jthkn9's Final Project
//
//  Created by jackson on 8/1/19.
//  Copyright © 2019 jackson. All rights reserved.
//
import UIKit
import Foundation

protocol PlayerViewControllerDelegate: class {
    func delete(player: Player)
    func updatePlayer(new: Player,old: Player)
}

protocol SeasonViewControllerDelegate {
    func update(season: Seasons)
    func add(season: Seasons)
}

final class PlayerViewController: UIViewController {
    
    @IBOutlet private weak var NameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    //private var player: Player!
    
    weak var delegate: PlayerViewControllerDelegate?
    
    private var model: PlayerSelectModel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NameLabel.text = model.getPlayer().name
    }
    
    @IBAction func AddPressed(_ sender: Any) {
        performSegue(withIdentifier: "Season", sender: model.getYears())
    }
    @IBAction func DeleteButton(_ sender: Any) {
        delegate?.delete(player: model.getPlayer())
    }
    
    //prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let VC = segue.destination as! SeasonViewController
        if let send = sender as? Seasons{
            VC.setup(seasons: send, delegate: self)
        }
        else{
            VC.setup(currentYears: sender as! [Int], delegate: self)
        }
    }
    
}


extension PlayerViewController {
    func setup(player: Player, delegate: PlayerViewControllerDelegate){
        //model.setPlayer(player: player)
        self.delegate = delegate
        model = PlayerSelectModel(player: player)
    }
}
extension PlayerViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeasonCell", for: indexPath) as! PlayerTableViewCell
        cell.setup(with: model.getSeason(index: indexPath.row))
        print(cell)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Season", sender: model.getSeason(index: indexPath.row))
    }
    
    
}
extension PlayerViewController: SeasonViewControllerDelegate{
    func update(season: Seasons) {
        //update the current player local
        let old = model.getPlayer()
        
        model.updateSeason(season: season)
        //add the player data to persistance
        delegate?.updatePlayer(new: model.getPlayer(), old: old)
        tableView.reloadData()
    }
    
    func add(season: Seasons) {
        //add the season to current player local
        let old = model.getPlayer()
        model.addSeason(season: season)
        //add the player data to persistance
        delegate?.updatePlayer(new: model.getPlayer(), old: old)
        tableView.reloadData()
    }
    
    
}
