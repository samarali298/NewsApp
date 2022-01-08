//
//  UIButton+GradientBackGround.swift
//  NewsApp
//
//  Created by Samar Ali on 1/8/22.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit

extension UIButton {
    func setGradientBackGround(radius: CGFloat = 0.0, first: CGColor, second: CGColor, bounds: CGRect? = nil, startPoint: CGPoint = CGPoint(x: 0, y: 0), endPoint: CGPoint = CGPoint(x: 1, y: 0)) {
        let gradient = CAGradientLayer()
        let bounds = bounds
        gradient.frame = bounds ?? self.bounds
        let colors: [CGColor] = [first, second]
        gradient.colors = colors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        self.setBackgroundImage(getImageFrom(gradientLayer: gradient), for: .normal)
        gradient.cornerRadius = radius
        self.clipsToBounds = true
        self.setBackgroundImage(getImageFrom(gradientLayer: gradient), for: .normal)
    }
    
    func getImageFrom(gradientLayer: CAGradientLayer) -> UIImage? {
        var gradientImage: UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }

}

