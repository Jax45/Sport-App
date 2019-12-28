import UIKit
import Foundation

protocol TeamListViewControllerDelegate: class {
    func teamAdded()
    func dataImported()
}

protocol TeamUpdateDelegate: class {
    func submit(name: String, logo: String)
}

final class TeamListViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    weak var delegate: TeamListViewControllerDelegate?
    
    private var model: TeamListModel!
    private var selectedTeam: Int = 0
    
}
extension TeamListViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let importButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(importTapped))
        self.navigationItem.setLeftBarButton(importButton, animated: true)
        
        let addPlayerButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlayerTapped))
        //self.navigationItem.setRightBarButton(addPlayerButton, animated: true)
        let sendJsonButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sendTapped))
        //self.navigationItem.setRightBarButton(sendJsonButton, animated: true)
        navigationItem.rightBarButtonItems = [addPlayerButton, sendJsonButton]
        tableView.dataSource = self
        tableView.delegate = self
        model.setDelegate(delegate: self)
        //model.connectToScaledrone()
        
    }
    
    static func instanceOfParent(model: TeamListModel) -> UINavigationController {
        let navigationController = UINavigationController.with(storyboardName: "TeamList")
        let viewController = navigationController.rootViewController(asType: TeamListViewController.self)
        viewController.setup(model: model)
        return navigationController
    }
    
    func setup(model: TeamListModel){
        self.model = model
    }
    
    @objc func addPlayerTapped() {
        
        performSegue(withIdentifier: "TeamUpdate", sender: nil)
    }
    @objc func sendTapped(){
        //if not authenticated ask.
        let defaults = UserDefaults.standard
        if let auth = defaults.object(forKey: "Auth") as? Int {
            //is authenticated
            if auth == 2 {
                let jsonData = try! JSONEncoder().encode(model.getAllTeams())
                
                let message: String = "Careful, this will overwrite the current database on the server."
                let title: String = "Update Server Database"
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction.init(title: "Yes", style: UIAlertAction.Style.default, handler: {[weak self](action) in alert.dismiss(animated: true, completion: nil)
                    
                    let jsonUpdateString = String(data: jsonData, encoding: .utf8)!
                    
                    print(jsonUpdateString)
                    self?.model.send(msg: jsonUpdateString)
                }))
                alert.addAction(UIAlertAction.init(title: "No", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
                //model.send(msg: "")
            }
            else{
                let message: String = "You do not have the authentication to export data."
                let title: String = "Denied"
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.default))
                self.present(alert, animated: true, completion: nil)

            }
        }
        else{
            let message: String = "You are not logged in, please log in."
            let title: String = "Not Authenticated."
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.default))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    @objc func importTapped(){
        let defaults = UserDefaults.standard
        if let auth = defaults.object(forKey: "Auth") as? Int {
            //is authenticated
            if auth == 2 || auth == 1{
                let message: String = "Would you like to import data from json?"
                let title: String = "Import Data"
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction.init(title: "Yes", style: UIAlertAction.Style.default, handler: {[weak self](action) in alert.dismiss(animated: true, completion: nil)
                    //print("Yes")
                    self!.model.importTeamsFromJson()
                    
                }))
                alert.addAction(UIAlertAction.init(title: "No", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
            else{
                let message: String = "You are not logged in, please log in."
                let title: String = "Not Authenticated."
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.default))
                self.present(alert, animated: true, completion: nil)
            }
        }
        else{
            let message: String = "You are not logged in, please log in."
            let title: String = "Not Authenticated."
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let teamViewController = segue.destination as? TeamViewController {
            guard let team = sender as? Team else {return}
            let teamModel = TeamModel(team: team)
            teamViewController.setup(model: teamModel)
        }
        else {
            if let updateVC = segue.destination as? TeamUpdateViewController {
                updateVC.delegate = self
            }
//            guard let playerCreationViewController = segue.destination as? PlayerCreationViewController else {return}
//            guard let teams = sender as? [(Int, String)] else {return}
//    
//        // dont pass the persistence. your model in this file already has persistence and should just get the stuff it needs first
//            // pass the team ids and names (names for display)
//            
//            let teamsModel = PlayerCreationModel(teams: teams, delegate: self)
//            playerCreationViewController.setup(model: teamsModel)
        }
    }
}

//extension TeamListViewController: TeamModelDelegate {
//    func save(player: Player) {
//        // model.save(player: player) which will call persistence
//        model.save(player: player)
//        tableView.reloadData()
//        navigationController?.popViewController(animated: true)
//         delegate?.playerAdded()
//    }
//}

extension TeamListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell")! as! TeamListTableViewCell
        cell.setup(with: model.getTeamAtIndex(atIndex: indexPath.row)!)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

extension TeamListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTeam = indexPath.row
        performSegue(withIdentifier: "TeamView", sender: model.team(atIndex: indexPath.row))
    }
}

extension TeamListViewController: TeamListModelDelegate {
    func dataRefreshed() {
        tableView.reloadData()
        delegate?.dataImported()
    }
}

extension TeamListViewController: AllPlayersViewControllerDelegate {
    func playerUpdate() {
        // model pull the update from persistence
        model.importTeamsFromPersistance()

        tableView.reloadData()
    }
}
extension TeamListViewController: TeamUpdateDelegate{
    func submit(name: String, logo: String) {
        //update persistance
        model.save(teamToSave: Team(id: UUID(), logo: logo, teamName: name, roster: [], wins: 0, losses: 0))
        //pull back from persistance
        delegate?.teamAdded()
        
        tableView.reloadData()
    }
    
    
}
