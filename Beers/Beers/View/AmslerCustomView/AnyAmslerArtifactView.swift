//
//  AnyAmslerArtifactView.swift
//  Beers
//
//  Created by Mobile Team on 18/11/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation
import UIKit

protocol AnyAmslerArtifactView: UIButton {
    var distortionImage : UIImage? { get }
    func draw(_ rect: CGRect)
}
