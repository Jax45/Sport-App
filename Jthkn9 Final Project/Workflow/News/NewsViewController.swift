//
//  NewsViewController.swift
//  Jthkn9 Final Project
//
//  Created by user159466 on 12/9/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    private var model: NewsModel!
    private let inset: CGFloat = 15.0
    private let height: CGFloat = 300
    private let linespacing: CGFloat = 15.0
    static func instanceOfParent() -> UINavigationController {
           let navigationController = UINavigationController.with(storyboardName: "News")
           return navigationController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = NewsModel()

        // Do any additional setup after loading the view.
    }

}
extension NewsViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return model.getCount()/2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCollectionViewCell
        let news = model.getNews(atIndex: indexPath.section + (2*indexPath.item))
        cell.setup(headline: news.headline, image: UIImage(named: news.imageString)!, descrip: news.description)
        return cell
    }
    
    
}
extension NewsViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: (UIScreen.main.bounds.width - 2*inset - linespacing)/2, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return linespacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}
