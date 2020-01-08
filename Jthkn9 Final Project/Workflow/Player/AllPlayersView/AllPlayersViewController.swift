//
//  AllPlayersViewController.swift
//  Jthkn9's Final Project
//
//  Created by jackson on 7/25/19.
//  Copyright © 2019 jackson. All rights reserved.
//
import UIKit
import Foundation

protocol AllPlayersViewControllerDelegate: class {
    func playerUpdate()
}

final class AllPlayersViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var model: AllPlayersModel!

    weak var delegate: AllPlayersViewControllerDelegate?
}

extension AllPlayersViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        title = "All Players Stats"
    }
    
    static func instanceOfParent(model: AllPlayersModel) -> UINavigationController {
        let navigationController = UINavigationController.with(storyboardName: "AllPlayers")
        let viewController = navigationController.rootViewController(asType: AllPlayersViewController.self)
        viewController.setup(model: model)
        return navigationController
    }
    
    func setup(model: AllPlayersModel){
        self.model = model
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let playerViewController = segue.destination as? PlayerViewController {
            let player: Player = (sender as? Player)!
            playerViewController.setup(player: player, delegate: self, teams: model.getTeamTupleArray())
        }
        else if let createVC = segue.destination as? PlayerCreationViewController {
            let playerModel = PlayerCreationModel(teams: model.getTeamTupleArray(), delegate: self)

            createVC.setup(model: playerModel)
        }
        else if let filterVC = segue.destination as? FilterPlayersViewController {
            filterVC.delegate = self
        }
    }
}

extension AllPlayersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllPlayerCell")! as! PlayerTableViewCell
        cell.setup(with: (model?.getPlayer(atIndex: indexPath.row))!)
        return cell
    }
}

extension AllPlayersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "PlayerView", sender: model.getPlayer(atIndex: indexPath.row))
    }
}

extension AllPlayersViewController: AllPlayersModelDelegate {
    func dataRefreshed() {
        tableView.reloadData()
    }
}
    
extension AllPlayersViewController: PlayerViewControllerDelegate {
    func delete(player: Player) {
        // model delete stuff
        model.deletePlayer(player: player)
        model.importDataFromPersistance()
        
        delegate?.playerUpdate()
        tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    func updatePlayer(new: Player,old: Player){
        //delete the player from persistance and add it back.
        model.deletePlayer(player: old)
        model.addPlayer(player: new)
        model.importDataFromPersistance()
        delegate?.playerUpdate()
        tableView.reloadData()
    }
}
extension AllPlayersViewController: filterPlayersDelegate{
    func filterTeams(filter: String) {
        model.filter(filter: filter)
        tableView.reloadData()
    }
    
    
}

extension AllPlayersViewController: TeamListViewControllerDelegate {
    
    func dataImported() {
        model.importDataFromPersistance()
        tableView?.reloadData()
    }
    
    func teamAdded() {
        // model pull fresh from persistence
        // this question mark wraps the tableview again in the event the user hasn't visited the player table and allocated that VC
        model.importDataFromPersistance()
        tableView?.reloadData()
    }
}
extension AllPlayersViewController: PlayerCreationDelegate{
    func save(player: Player) {
        model.save(player: player)
        model.importDataFromPersistance()
        delegate?.playerUpdate()
        tableView?.reloadData()
    }
    
    
}
