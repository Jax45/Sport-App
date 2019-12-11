//
//  NewsCollectionViewCell.swift
//  Jthkn9 Final Project
//
//  Created by user159466 on 12/9/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import UIKit
final class NewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var HeadlineLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    func setup(headline: String,image: UIImage,descrip: String){
        HeadlineLabel.text = headline
        imageView.image = image
        DescriptionLabel.text = descrip
    }
}
