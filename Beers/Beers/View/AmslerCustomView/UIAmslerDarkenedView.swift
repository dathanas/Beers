//
//  UIBlackCircleView.swift
//  Beers
//
//  Created by Mobile Team on 12/11/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class UIAmslerDarkenedView: UIButton, AnyAmslerArtifactView {
    var distortionImage: UIImage?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        var blackCircleRect = rect.insetBy(dx: 1.0, dy: 1.0)
        let minSide = min(blackCircleRect.width, blackCircleRect.height)
        
        if blackCircleRect.width < blackCircleRect.height {
            blackCircleRect = .init(x: 0, y: (blackCircleRect.height/2) - (blackCircleRect.width/2), width: minSide, height: minSide)
        } else {
            blackCircleRect = .init(x: (blackCircleRect.width/2) - (blackCircleRect.height/2), y: 0, width: minSide, height: minSide)
        }
        
        let context = UIGraphicsGetCurrentContext()
        let blackCirclePath = UIBezierPath(ovalIn: blackCircleRect)
        blackCirclePath.usesEvenOddFillRule = true
        
        context?.addPath(blackCirclePath.cgPath)
        
        context?.setFillColor(UIColor.black.withAlphaComponent(0.3).cgColor)
        context?.setStrokeColor(UIColor.white.withAlphaComponent(0.3).cgColor)
        context?.drawPath(using: .eoFillStroke)
    }
    
}
