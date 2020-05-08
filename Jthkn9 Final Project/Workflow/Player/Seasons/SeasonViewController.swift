//
//  SeasonViewController.swift
//  Jthkn9 Final Project
//
//  Created by user159466 on 12/10/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import UIKit

class SeasonViewController: UIViewController, UITextFieldDelegate {
    private var delegate: SeasonViewControllerDelegate!
    //private var years: [Int] = []
    private var model: SeasonModel!
    @IBOutlet weak var YearLabel: UITextField!
    @IBOutlet weak var HitsLabel: UITextField!
    @IBOutlet weak var AtBatsLabel: UITextField!
    @IBOutlet weak var HomeRunsLabel: UITextField!
    @IBOutlet weak var RunsLabel: UITextField!
    @IBOutlet weak var RBILabel: UITextField!
    @IBOutlet weak var WalksLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let seasons = model.getSeason()
        YearLabel.text = "\(seasons.year)"
        if model.isUpdate(){
            YearLabel.isUserInteractionEnabled = false
        }
        HitsLabel.text = "\(seasons.hits)"
        AtBatsLabel.text = "\(seasons.atBat)"
        HomeRunsLabel.text = "\(seasons.homeRuns)"
        RunsLabel.text = "\(seasons.runs)"
        RBILabel.text = "\(seasons.rBIS)"
        WalksLabel.text = "\(seasons.walks)"
        YearLabel.delegate = self
        HitsLabel.delegate = self
        AtBatsLabel.delegate = self
        RunsLabel.delegate = self
        RBILabel.delegate = self
        WalksLabel.delegate = self
        
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func setup(seasons: Seasons,delegate: SeasonViewControllerDelegate){
        self.delegate = delegate
        model = SeasonModel(years: [], season: seasons)
        model.setUpdate()
    }
    func setup(currentYears: [Int],delegate: SeasonViewControllerDelegate){
        self.delegate = delegate
        model = SeasonModel(years: currentYears, season: Seasons(year: 2000, atBat: 0, runs: 0, walks: 0, homeRuns: 0, rBIS: 0, hits: 0))
    }

    @IBAction func SubmitPressed(_ sender: Any) {
        
        //check for ints
        guard let hits = Int(HitsLabel.text!),
            let year = Int(YearLabel.text!),
            let atBat = Int(AtBatsLabel.text!),
            let runs = Int(RunsLabel.text!),
            let walks = Int(WalksLabel.text!),
            let homeRuns = Int(HomeRunsLabel.text!),
            let RBI = Int(RBILabel.text!)
        else {return}
        if model.hasYear(year: year) {
            //can't add the same year.
            return
        }
        if(model.isUpdate()){
            delegate.update(season: Seasons(year: year, atBat: atBat, runs: runs, walks: walks, homeRuns: homeRuns, rBIS: RBI, hits: hits))
        }
        else{
            delegate.add(season: Seasons(year: year, atBat: atBat, runs: runs, walks: walks, homeRuns: homeRuns, rBIS: RBI, hits: hits))
            
        }
        navigationController?.popViewController(animated: true)
    }


}
