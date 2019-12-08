//
//  UIColor.swift
//  Jthkn9 Final Project
//
//  Created by user159466 on 12/6/19.
//  Copyright © 2019 jackson. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
  static var random: UIColor {
    return UIColor(
      red: CGFloat.random(in: 0...1),
      green: CGFloat.random(in: 0...1),
      blue: CGFloat.random(in: 0...1),
      alpha: 1)
  }
  convenience init(hex: String) {
    var hex = hex
    if hex.hasPrefix("#") {
        hex.remove(at: hex.startIndex)
    }
    
    var rgb: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&rgb)

    let r = (rgb & 0xff0000) >> 16
    let g = (rgb & 0xff00) >> 8
    let b = rgb & 0xff
    
    self.init(
      red: CGFloat(r) / 0xff,
      green: CGFloat(g) / 0xff,
      blue: CGFloat(b) / 0xff,
      alpha: 1
    )
  }
  
  var hexString: String {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0
    
    self.getRed(&r, green: &g, blue: &b, alpha: &a)
    
    return String(
      format: "#%02X%02X%02X",
      Int(r * 0xff),
      Int(g * 0xff),
      Int(b * 0xff)
    )
  }
}

