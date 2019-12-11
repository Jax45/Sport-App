//
//  SeasonModel.swift
//  Jthkn9 Final Project
//
//  Created by user159466 on 12/10/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation
class SeasonModel{
    private var currentYears: [Int]
    private var update = false
    
    init(years: [Int]) {
        currentYears = years
    }
    func hasYear(year: Int) -> Bool {
        return currentYears.contains(year)
    }
    func setUpdate(){
        update = true
    }
    func isUpdate() -> Bool{
        return update
    }
}
