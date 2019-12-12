//
//  IconView.swift
//  Jthkn9 Final Project
//
//  Created by user159466 on 12/12/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import UIKit
class IconView: UIView{
    
    private let iconLayer: IconLayer
    
    init(frame: CGRect,red: Float, green: Float, blue: Float) {
        iconLayer = IconLayer(red: red, green: green, blue: blue)
        super.init(frame: .zero)
        layer.addSublayer(iconLayer)
    }
    func setColors(red: Float, green: Float, blue: Float){
        iconLayer.setColors(red: red, green: green, blue: blue)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        iconLayer.frame = rect
    }
}
