//
//  BeerAlcoholDensity.swift
//  Beers
//
//  Created by Mobile Team on 29/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation

enum BeerAlcoholDensity: Int, CaseIterable {
    case light
    case normal
    case strong
    case extraStrong
    
    static func from(abv: Double) -> BeerAlcoholDensity? {
        if abv >= 0 && abv < 6 {
            return .light
        } else if abv >= 6 && abv < 9 {
            return .normal
        } else if abv >= 9 && abv < 13 {
            return .strong
        } else if abv >= 13 {
            return .extraStrong
        } else {
            return nil
        }
    }
}
