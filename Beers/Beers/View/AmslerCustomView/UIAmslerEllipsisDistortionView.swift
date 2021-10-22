//
//  UIWhiteCircleView.swift
//  Beers
//
//  Created by Mobile Team on 12/11/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class UIAmslerEllipsisDistortionView: UIButton, AnyAmslerArtifactView {
    var distortionImage: UIImage?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        var whiteCircleRect = rect.insetBy(dx: 1.0, dy: 1.0)
        let minSide = min(whiteCircleRect.width, whiteCircleRect.height)
        
        if whiteCircleRect.width < whiteCircleRect.height {
            whiteCircleRect = .init(x: 0, y: (whiteCircleRect.height/2) - (whiteCircleRect.width/2), width: minSide, height: minSide)
        } else {
            whiteCircleRect = .init(x: (whiteCircleRect.width/2) - (whiteCircleRect.height/2), y: 0, width: minSide, height: minSide)
        }
        
        let context = UIGraphicsGetCurrentContext()
        let whiteCirclePath = UIBezierPath(ovalIn: whiteCircleRect)
        whiteCirclePath.usesEvenOddFillRule = true
        
        context?.addPath(whiteCirclePath.cgPath)
        
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.setFillColor(UIColor.white.cgColor)
        
        context?.drawPath(using: .eoFillStroke)
    }
    
}
