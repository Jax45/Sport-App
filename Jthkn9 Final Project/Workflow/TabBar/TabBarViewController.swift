//
//  TabBarViewController.swift
//  Jthkn9's Final Project
//
//  Created by jackson on 8/2/19.
//  Copyright © 2019 jackson. All rights reserved.
//
import UIKit
import Foundation

final class TabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init persistence, these will be passed to your ViewControllers
        // so that when changes occur on different screens, they can be notified
        // And pull the modified objects straight from their storage location
        let model = TabBarModel()
        guard let persist = model.appPersistence else {return}
        
        setupViewControllers(teams: model.teams, appPersistence: persist, players: model.players)
        
    }
}

extension TabBarViewController {
    
    // Set up ViewControllers
    // This is best done programmatically so as to set delegates/datasaources/etc at time of init
    // rather than having to deal with updating things after the app finishes presenting its initial views
    private func setupViewControllers(teams: [Team], appPersistence: AppPersistence, players: [Player]) {
        let teamListModel = TeamListModel(persistence: appPersistence, teams: teams)
        let teamListNavigationViewController = TeamListViewController.instanceOfParent(model: teamListModel)
        
        let playerListModel = AllPlayersModel(persistence: appPersistence, teams: teams, players: players)
        let playerListNavigationViewController = AllPlayersViewController.instanceOfParent(model: playerListModel)
        
        let messageNavViewController = MessageViewController.instanceOfParent()
        
        let newsNavViewController = NewsViewController.instanceOfParent()
        
        let authNavViewController = AuthViewController.instanceOfParent()
        
        let teamListViewController = teamListNavigationViewController.rootViewController(asType: TeamListViewController.self)
        let playerListViewController = playerListNavigationViewController.rootViewController(asType: AllPlayersViewController.self)
        //let messageViewController = messageNavViewController.rootViewController(asType: MessageViewController.self)
        teamListViewController.delegate = playerListViewController
        playerListViewController.delegate = teamListViewController
        
        setViewControllers([teamListNavigationViewController, playerListNavigationViewController, messageNavViewController,newsNavViewController,authNavViewController], animated: true)
    }
}
