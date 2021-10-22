//
//  UIAmslerGridView.swift
//  Beers
//
//  Created by Mobile Team on 2/11/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import UIKit

@IBDesignable
class UIAmslerGridView: UIView {
    
    private class ViewDetails {
        var view: AnyAmslerArtifactView
        var point: CGPoint
        var size: CGFloat
        
        init(view: AnyAmslerArtifactView, point: CGPoint, size: CGFloat) {
            self.view = view
            self.point = point
            self.size = size
        }
    }
    
    //line types
    enum LineWidth {
        case light
        case normal
        case bold
        case none

        static func get(_ lineWidth: LineWidth?) -> LineWidth {
            if lineWidth == .bold {
                return .bold
            } else if lineWidth == .normal {
                return .normal
            } else if lineWidth == .light {
                return .light
            } else {
                return .none
            }
        }

        var widthInPoints: CGFloat {
            get {
                switch self {
                case .light:
                    return UIScreen.toPointsOrSimulate(millimeters: 0.1454)
                case .normal:
                    return UIScreen.toPointsOrSimulate(millimeters: 0.2908)
                case .bold:
                    return UIScreen.toPointsOrSimulate(millimeters: 1.1632)
                case .none:
                    return 0.0
                }
            }
        }
    }

    //shape types
    enum Shape {
        case square
        case rectangle
    
        static func get(_ shape: Shape) -> Shape {
            if shape == .square {
                return .square
            } else {
                return .rectangle
            }
        }
    }
    
    enum ArfifactType {
        case ellipsis
        case distortion
        case darkened
        
        static func get(_ artifact: ArfifactType) -> ArfifactType {
            switch artifact {
            case .ellipsis:
                return .ellipsis
            case .distortion:
                return .distortion
            case .darkened:
                return .darkened
            }
        }
    }

    var lineWidth: LineWidth = .light {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var shape: Shape = .square {
        didSet {
            setNeedsDisplay()
        }
    }

    var artifactType: ArfifactType? = nil {
        didSet {
            setNeedsDisplay()
        }
    }
    
    private var ellipsisArray: [ViewDetails] = []
    private var darkenedArray: [ViewDetails] = []
    private var distortionArray: [ViewDetails] = []
    
    let ellipsisView = UIAmslerEllipsisDistortionView()
    let darkenedView = UIAmslerDarkenedView()
    let distortionView = UIAmslerDistortionView()
    
    
    let cellSize = UIScreen.toPointsOrSimulate(millimeters: 5.8162)
    var grid: CGRect!
    var tapPoint: CGPoint!

    override func draw(_ rect: CGRect) {
        //Drawing code
        super.draw(rect)
        
        let lineWidth = LineWidth.get(self.lineWidth)
        let shape = Shape.get(self.shape)

        let backgroundRect = rect.insetBy(dx: 0.0, dy: 0.0)

        let viewHeight = backgroundRect.height
        let viewWidth = backgroundRect.width

        //even number of vertical and horizontal cells that can fit in backgoundRect
        let verticalCells = numberOfCells(for: viewWidth, with: lineWidth.widthInPoints)
        let horizontalCells = numberOfCells(for: viewHeight, with: lineWidth.widthInPoints)
        
        let context = UIGraphicsGetCurrentContext()

        //background with white fill
        let backgroundPath = UIBezierPath(rect: backgroundRect)
        backgroundPath.usesEvenOddFillRule = true

        context?.addPath(backgroundPath.cgPath)
        context?.setFillColor(UIColor.white.cgColor)
        context?.drawPath(using: .fill)

        //grid
        var gridRect = backgroundRect.insetBy(dx: 0.0, dy: 0.0)
        
        context?.setLineWidth(lineWidth.widthInPoints)

        //draw rectangle
        if shape == .rectangle {
            //cells space
            let verticalCellsSpace = (CGFloat(verticalCells) * cellSize)
            let horizontalCellsSpace = (CGFloat(horizontalCells) * cellSize)
            
            //lines space
            let verticalLinesSpace = lineWidth.widthInPoints * CGFloat(verticalCells + 1)
            let horizontalLinesSpace = lineWidth.widthInPoints * CGFloat(horizontalCells + 1)

            //filled space
            let verticalFilledSpace = verticalCellsSpace + verticalLinesSpace
            let horizontalFilledSpace = horizontalCellsSpace + horizontalLinesSpace
            
            //empty space
            let emptyVerticalSpace = gridRect.width - verticalFilledSpace
            let emptyHorizontalSpace = gridRect.height - horizontalFilledSpace
            
            //rectangle origin
            gridRect.origin = CGPoint(x: emptyVerticalSpace/2, y: emptyHorizontalSpace/2)
            
            gridRect = drawLines(vCells: verticalCells, hCells: horizontalCells, origin: gridRect.origin, lineWidth: lineWidth, hFilledSpace: horizontalFilledSpace, vFilledSpace: verticalFilledSpace, context: context)
            
        //draw square
        } else if shape == .square {
            
            let squareSideCells: Int
            //get the smaller side
            if verticalCells < horizontalCells {
                squareSideCells = verticalCells
            } else {
                squareSideCells = horizontalCells
            }
            
            let cellsSpace = CGFloat(squareSideCells) * cellSize
            let linesSpace = (CGFloat(squareSideCells) + 1) * lineWidth.widthInPoints
            let filledSpace = cellsSpace + linesSpace
            let emptyVerticalSpace = gridRect.width - filledSpace
            let emptyHorizontalSpace = gridRect.height - filledSpace
            
            //square origin
            gridRect.origin = CGPoint(x: emptyVerticalSpace/2, y: emptyHorizontalSpace/2)
            
            gridRect = drawLines(vCells: squareSideCells, hCells: squareSideCells, origin: gridRect.origin, lineWidth: lineWidth, hFilledSpace: filledSpace, vFilledSpace: filledSpace, context: context)
        }
        grid = gridRect
        let gridPath = UIBezierPath(rect: gridRect)
        
        gridPath.usesEvenOddFillRule = false
        context?.addPath(gridPath.cgPath)
        context?.setFillColor(UIColor.white.cgColor)
        context?.drawPath(using: .fillStroke)
        
        //draw circle in the center of the grid
        var circleRect = rect.insetBy(dx: 0.0, dy: 0.0)
        
        let minSide = min(backgroundRect.width, backgroundRect.height)
        
        if circleRect.width < circleRect.height {
            circleRect = .init(x: 0, y: (circleRect.height/2) - (circleRect.width/2), width: minSide, height: minSide)
        } else {
            circleRect = .init(x: (circleRect.width/2) - (circleRect.height/2), y: 0, width: minSide, height: minSide)
        }
        
        //keep center of gridRect
        let center = CGPoint(x: circleRect.origin.x + circleRect.width/2, y: circleRect.origin.y + circleRect.height/2)
        
        let radius = UIScreen.toPointsOrSimulate(millimeters: 2.5)
        
        let circlePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        circlePath.usesEvenOddFillRule = true
        
        context?.addPath(circlePath.cgPath)
        context?.setFillColor(UIColor.black.cgColor)
        context?.drawPath(using: .fillStroke)
    }

    func numberOfCells(for viewSide: CGFloat, with lineWidth: CGFloat) -> Int {
        var numberOfCells = 0
        var remainingLength = viewSide
        remainingLength = remainingLength - lineWidth

        while remainingLength >= cellSize + lineWidth {
            remainingLength = remainingLength - (cellSize + lineWidth)
            numberOfCells += 1
        }

        if numberOfCells%2 != 0 {
            numberOfCells -= 1
        }

        return numberOfCells
    }
    
    fileprivate func drawLines(vCells: Int, hCells: Int, origin: CGPoint, lineWidth: LineWidth, hFilledSpace: CGFloat, vFilledSpace: CGFloat, context: CGContext?) -> CGRect {
        var firstXY = CGPoint(x: 0,y: 0)
        var lastXY  = CGPoint(x: 0,y: 0)
        
        //draw vertical lines
        for i in 0...vCells {
            let cellNum = CGFloat(i)
            let lineX = origin.x + (cellNum * (cellSize + lineWidth.widthInPoints)) + lineWidth.widthInPoints/2

            let start = CGPoint(x:lineX, y: origin.y)
            let end   = CGPoint(x:lineX, y: origin.y + hFilledSpace)
            
            context?.move(to: start)
            context?.addLine(to: end)
            
            if i == 0 {
                firstXY = start
            } else if i == vCells {
                lastXY = end
            }
        }
        
        //draw horizontal lines
        for i in 0...hCells {
            let cellNum = CGFloat(i)
            let lineY = origin.y + (cellNum * (cellSize + lineWidth.widthInPoints)) + lineWidth.widthInPoints/2

            let start = CGPoint(x:origin.x, y:lineY)
            let end   = CGPoint(x:origin.x + vFilledSpace, y:lineY)
            
            context?.move(to: start)
            context?.addLine(to: end)
        }
        
        let size = CGSize(width: lastXY.x - firstXY.x ,height: lastXY.y - firstXY.y)
        return CGRect(origin: firstXY, size: size)
    }
    
    func getTapPositionBy(_ point: CGPoint) -> Bool {
        if (point.x >= grid.origin.x && point.x <= grid.width + grid.origin.x) && ( point.y >= grid.origin.y && point.y <= grid.height + grid.origin.y) {
            print("tap spotted in grid rect")
            return true
        } else {
            print("tap spotted out of grid")
            return false
        }
    }
    
    func addDistortionView(_ view: AnyAmslerArtifactView, at centerPoint: CGPoint) {
        print(view)
        print(darkenedView)
        if view == ellipsisView {
            let details = ViewDetails(view: view as! UIAmslerEllipsisDistortionView, point: centerPoint, size: 3.0)
            ellipsisArray.append(details)
            addSubview(view)
            layoutSubviews()
        } else if view == darkenedView {
            let details = ViewDetails(view: view as! UIAmslerDarkenedView, point: centerPoint, size: 3.0)
            darkenedArray.append(details)
            addSubview(view)
            layoutSubviews()
        } else if view == distortionView {
            let details = ViewDetails(view: view as! UIAmslerDistortionView, point: centerPoint, size: 3.0)
            distortionArray.append(details)
            addSubview(view)
            layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        if !ellipsisArray.isEmpty {
            ellipsisArray.forEach { (ViewDetails) in
                ViewDetails.view.draw(CGRect(origin: CGPoint(x: ViewDetails.point.x - ViewDetails.size/2, y: ViewDetails.point.y - ViewDetails.size/2 )  , size: CGSize(width: ViewDetails.size, height: ViewDetails.size)))
            }
        }
        
        if !darkenedArray.isEmpty {
            darkenedArray.forEach { (ViewDetails) in
                ViewDetails.view.draw(CGRect(origin: CGPoint(x: ViewDetails.point.x - ViewDetails.size/2, y: ViewDetails.point.y - ViewDetails.size/2 )  , size: CGSize(width: ViewDetails.size, height: ViewDetails.size)))
            }
        }
        
        if !distortionArray.isEmpty {
            distortionArray.forEach { (ViewDetails) in
                ViewDetails.view.draw(CGRect(origin: CGPoint(x: ViewDetails.point.x - ViewDetails.size/2, y: ViewDetails.point.y - ViewDetails.size/2 )  , size: CGSize(width: ViewDetails.size, height: ViewDetails.size)))
                ViewDetails.view.setImage(ViewDetails.view.distortionImage, for: .normal)
            }
        }

    }
    
    override func setNeedsDisplay() {
        super.setNeedsDisplay()
    }
}
