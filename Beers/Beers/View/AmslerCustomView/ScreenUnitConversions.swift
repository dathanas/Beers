//
//  ScreenUnitConversions.swift
//  Life4LV
//
//  Created by Sakis Kefalas on 10/9/20.
//  Copyright © 2020 msensis. All rights reserved.
//

import UIKit
import GBDeviceInfo

extension UIScreen {
    
    static func toMillimeters(points: CGFloat) -> CGFloat? {
        let screenDiagonalSizePoints = main.bounds.size.diagonalLength()
        guard let screenDiagonalSizeMM = physicalSizeMillimeters()?.diagonalLength() else {
            return nil
        }
        
        return (points * screenDiagonalSizeMM) / screenDiagonalSizePoints
    }
    
    static func toPoints(millimeters: CGFloat) -> CGFloat? {
        let screenDiagonalSizePoints = main.bounds.size.diagonalLength()
        guard let screenDiagonalSizeMM = physicalSizeMillimeters()?.diagonalLength() else {
            return nil
        }
        
        return (millimeters * screenDiagonalSizePoints) / screenDiagonalSizeMM
    }
    
    static func toPointsOrSimulate(millimeters: CGFloat) -> CGFloat {
        return toPoints(millimeters: millimeters) ?? (32.0866 * millimeters) / 5
    }
    
    /**
    * Physical device screen size in millimeters
    */
    static func physicalSizeMillimeters() -> CGSize? {
        guard let ppi = pointsPerInch(), ppi != 0 else {
            return nil
        }
        
        let mmPerInch = CGFloat(25.4)
        
        let width = (UIScreen.main.nativeBounds.width * mmPerInch) / ppi
        let height = (UIScreen.main.nativeBounds.height * mmPerInch) / ppi

        return CGSize(width: width, height: height)
    }
    
    static func pointsPerInch() -> CGFloat? {
        let deviceInfo = GBDeviceInfo()
        let displayInfo = deviceInfo.displayInfo
        
        return displayInfo.pixelsPerInch
    }
}

fileprivate extension CGSize {
    
    func diagonalLength() -> CGFloat {
        return  sqrt(pow(width, 2) + pow(height, 2))
    }
    
}
