//
//  NewsModel.swift
//  Jthkn9 Final Project
//
//  Created by user159466 on 12/9/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation
class NewsModel{
    private var newsStories: [NewsStory] = [NewsStory(headline: "Trade", description: "Zach Gunn to Noob Nugs", action: 1, imageString: "NoobNugs"),NewsStory(headline: "New Pickup", description: "Lebron James signs with Special K's", action: 1, imageString: "SpecialK"),NewsStory(headline: "Trade", description: "Zach C. to Dinos", action: 1, imageString: "Dino"),NewsStory(headline: "2019 Champs", description: "Commitee Wins over RGCV at World Series", action: 1, imageString: "Commitee")]
    
    func getNews(atIndex: Int) -> NewsStory{
        return newsStories[atIndex]
    }
    func getCount() -> Int{
        return newsStories.count
    }
}
