//
//  NewsModel.swift
//  Jthkn9 Final Project
//
//  Created by user159466 on 12/9/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation
class NewsModel{
    private var newsStories: [NewsStory] = [NewsStory(headline: "Test headline", description: "Description ...", action: 1, imageString: "RGCV"),NewsStory(headline: "Test headline", description: "Description ...", action: 1, imageString: "RGCV"),NewsStory(headline: "Test headline", description: "Description ...", action: 1, imageString: "RGCV"),NewsStory(headline: "Test headline", description: "Description ...", action: 1, imageString: "RGCV")]
    
    func getNews(atIndex: Int) -> NewsStory{
        return newsStories[atIndex]
    }
    func getCount() -> Int{
        return newsStories.count
    }
}
