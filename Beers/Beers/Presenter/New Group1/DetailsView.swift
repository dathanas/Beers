//
//  DetailsView.swift
//  Beers
//
//  Created by Mobile Team on 20/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsView {
    func getImage(from url: String)
    func didGetBeer(_ beer: Beer)
}
