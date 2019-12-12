//
//  ProfileView.swift
//  Jthkn9 Final Project
//
//  Created by user159466 on 12/12/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import UIKit
class ProfileView: UIView{
    let circle = CAShapeLayer()
    
    override func addSubview(_ view: UIView) {
        super.addSubview(view)
        setupView(view)
    }
    func newColors(red: Float, green: Float, blue: Float){
        let sub = subviews.first as! IconView
            sub.setColors(red: red, green: green, blue: blue)
    }
    private func setupView(_ view: UIView) {
        subviews.forEach { (subview) in
            if view === subview {
                view.translatesAutoresizingMaskIntoConstraints = false
                view.topAnchor.constraint(equalTo: topAnchor).isActive = true
                view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
                view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
                view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
                view.setNeedsLayout()
            }
        }
    }
}
