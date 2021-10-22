//
//  UIBeerDensityView.swift
//  Beers
//
//  Created by Mobile Team on 29/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import UIKit

@IBDesignable
class UIBeerDensityView: UIView {
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    private enum Density {
        case none
        case light
        case normal
        case strong
        case extraStrong
        
        static func from(beerDensity: BeerAlcoholDensity?) -> Density {
            guard let density = beerDensity else {
                return .none
            }
            
            switch density {
            case .light:
                return .light
            case .normal:
                return .normal
            case .strong:
                return .strong
            case .extraStrong:
                return .extraStrong
            }
        }
        
        var backgroundColor: UIColor {
            get {
                switch self {
                case .none:
                    return .lightGray
                case .light:
                    return .systemBlue
                case .normal:
                    return .systemGreen
                case .strong:
                    return .systemOrange
                case .extraStrong:
                    return .systemRed
                }
            }
        }
        
        var startAngle: CGFloat {
            get {
                switch self {
                case .none:
                    return 0.0
                case .light:
                    return -CGFloat.pi/2.0
                case .normal:
                    return 0.0
                case .strong:
                    return CGFloat.pi/2.0
                case .extraStrong:
                    return CGFloat.pi
                }
            }
        }
    }
    
    private var _densityLabel = UILabel()
    
    var density: BeerAlcoholDensity? = nil {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var abv: Double = 0.0 {
        didSet {
            density = BeerAlcoholDensity.from(abv: abv)
            let abvString = String(format: "%.1f", abv)
            _densityLabel.text = "\(abvString)%"
        }
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        
        let density = Density.from(beerDensity: self.density)
        
        var backgroundRect = rect.insetBy(dx: 1.0, dy: 1.0)
        let minSide = min(backgroundRect.width, backgroundRect.height)
        
        if backgroundRect.width < backgroundRect.height {
            backgroundRect = .init(x: 0, y: (backgroundRect.height/2) - (backgroundRect.width/2), width: minSide, height: minSide)
        } else {
            backgroundRect = .init(x: (backgroundRect.width/2) - (backgroundRect.height/2), y: 0, width: minSide, height: minSide)
        }
        
        let context = UIGraphicsGetCurrentContext()
        
        //1. background layer
        let backgroundPath = UIBezierPath(ovalIn: backgroundRect)
        backgroundPath.usesEvenOddFillRule = true
        
        context?.addPath(backgroundPath.cgPath)
        
        context?.setStrokeColor(density.backgroundColor.cgColor)
        context?.setFillColor(density.backgroundColor.cgColor)
        
        context?.drawPath(using: .eoFillStroke)
        
        //2. empty progress layer
        let emptyProgressRect = backgroundRect.insetBy(dx: 8.0, dy: 8.0)
        let emptyProgressPath = UIBezierPath(ovalIn: emptyProgressRect)
        
        emptyProgressPath.usesEvenOddFillRule = true
        
        context?.addPath(emptyProgressPath.cgPath)
        
        context?.setLineWidth(8.0)
        context?.setStrokeColor(UIColor.systemGray4.cgColor)
        
        context?.drawPath(using: .eoFillStroke)
        
        if density == .none {
            return
        }
        
        //3. filled progress layer
        let halfPi = CGFloat.pi/2.0
        
        let startAngle = density.startAngle
        let endAngle = startAngle + halfPi
        
        let center = CGPoint(x: emptyProgressRect.origin.x + emptyProgressRect.width/2 , y: emptyProgressRect.origin.y + emptyProgressRect.height/2 )
        
        let radius = min(emptyProgressRect.width, emptyProgressRect.height) / 2.0
        let firstPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        context?.addPath(firstPath.cgPath)
        
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.setLineCap(.round)
        context?.drawPath(using: .eoFillStroke)
    }
    
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if _densityLabel.superview == nil {
            self.addSubview(_densityLabel)
            
            _densityLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let padding = CGFloat(16.0)
            let views = [
                "me" : self,
                "label" : _densityLabel
            ]
            
            let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(\(padding))-[label]-(\(padding))-|", options: .alignAllCenterX, metrics: nil, views: views)
            let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(padding))-[label]-(\(padding))-|", options: .alignAllCenterY, metrics: nil, views: views)
            
            self.addConstraints(hConstraints)
            self.addConstraints(vConstraints)
            
            //_densityLabel.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height)
            
            _densityLabel.font = UIFont.preferredFont(forTextStyle: .title2, compatibleWith: traitCollection)
            _densityLabel.textAlignment = .center
            _densityLabel.textColor = .white
        }
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        _densityLabel.layoutIfNeeded()
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        _densityLabel.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        _densityLabel.setNeedsLayout()
        super.layoutSubviews()
        _densityLabel.layoutSubviews()
    }
    
    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        _densityLabel.setNeedsDisplay()
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var size = _densityLabel.intrinsicContentSize
            size.height += 16.0 * 6.0
            size.width += 16.0 * 6.0
            
            let minimumSize = max(size.width, size.height)
            return CGSize(width: minimumSize, height: minimumSize)
        }
    }
    
    override func invalidateIntrinsicContentSize() {
        _densityLabel.invalidateIntrinsicContentSize()
        super.invalidateIntrinsicContentSize()
    }
}
