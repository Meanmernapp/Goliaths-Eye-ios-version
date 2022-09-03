//
//  UISlider.swift
//  ShaeFoodDairy
//
//  Created by Bilal Saeed on 3/26/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit


extension UISlider {
    
    func addGradientTrack(colorStart: UIColor = #colorLiteral(red: 0, green: 0.7019607843, blue: 0.8980392157, alpha: 1), colorEnd: UIColor = #colorLiteral(red: 0, green: 0.6980392157, blue: 0.5333333333, alpha: 1)) {
        superview?.layoutIfNeeded()
        setThumbImage(#imageLiteral(resourceName: "drag_no"), for: .normal)
        
        if UIScreen.main.bounds.width > 375 {
            setMaximumTrackImage(imageForColors(colors: [#colorLiteral(red: 0.8745098039, green: 0.8941176471, blue: 0.9333333333, alpha: 1).cgColor, #colorLiteral(red: 0.8745098039, green: 0.8941176471, blue: 0.9333333333, alpha: 1).cgColor], offset: -35.0), for: .normal)
            setMinimumTrackImage(imageForColors(colors: [colorStart.cgColor, colorEnd.cgColor], offset:  -35.0), for: .normal)
        } else {
            setMaximumTrackImage(imageForColors(colors: [#colorLiteral(red: 0.8745098039, green: 0.8941176471, blue: 0.9333333333, alpha: 1).cgColor, #colorLiteral(red: 0.8745098039, green: 0.8941176471, blue: 0.9333333333, alpha: 1).cgColor], offset: 4.0), for: .normal)
            setMinimumTrackImage(imageForColors(colors: [colorStart.cgColor, colorEnd.cgColor], offset:  4.0), for: .normal)
        }
    }

    private func imageForColors(colors: [CGColor], offset: CGFloat = 0.0) -> UIImage? {
        let layer = CAGradientLayer()
        
        layer.frame = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width - offset, height: bounds.height - 15)
        layer.cornerRadius = bounds.height / 3.5
        layer.colors = colors
        layer.endPoint = CGPoint(x: 1.0, y:  1.0)
        layer.startPoint = CGPoint(x: 0.0, y:  1.0)

        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0.0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let layerImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return layerImage?.resizableImage(withCapInsets: .zero)
    }
}
