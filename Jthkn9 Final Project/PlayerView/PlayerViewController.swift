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
}

final class PlayerViewController: UIViewController {
    
    @IBOutlet private weak var NameLabel: UILabel!
    
    private var player: Player!
    
    weak var delegate: PlayerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NameLabel.text = player.name
    }
    
    @IBAction func DeleteButton(_ sender: Any) {
        delegate?.delete(player: player)
    }
}

extension PlayerViewController {
    func setup(player: Player, delegate: PlayerViewControllerDelegate){
        self.player = player
        self.delegate = delegate
    }
}
