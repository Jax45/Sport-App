//
//  IconLayer.swift
//  Jthkn9 Final Project
//
//  Created by user159466 on 12/12/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import UIKit
class IconLayer: CALayer{

    private let circle = CAShapeLayer()
    
    private var profileColor: CGColor!
    init(red: Float,green: Float,blue: Float) {
        super.init()
        addSublayer(circle)
        
        self.profileColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1).cgColor
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func layoutSublayers() {
            guard frame != CGRect.zero else { return }
            circle.fillColor = profileColor
            circle.strokeColor = profileColor
            let path = CGMutablePath()
            path.addEllipse(in: self.bounds.insetBy(dx: 3, dy: 3))
            circle.path = path
    //        print(bounds)
            circle.frame = bounds
        }
    func setColors(red: Float, green: Float, blue: Float){
        profileColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: 1).cgColor
        guard frame != CGRect.zero else { return }
                circle.fillColor = profileColor
                circle.strokeColor = profileColor
                let path = CGMutablePath()
                path.addEllipse(in: self.bounds.insetBy(dx: 3, dy: 3))
                circle.path = path
                circle.frame = bounds
    }

}
