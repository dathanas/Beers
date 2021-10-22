//
//  Beer.swift
//  Beers
//
//  Created by Mobile Team on 13/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation

struct Beer: Decodable, Equatable {
    let id: Int
    let name: String
    let tagline: String
    let description: String
    let imageUrl: String
    let abv: Double
    let firstBrewed: String
    let foodPairing: [String]
    let brewersTips: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline
        case description
        case imageUrl = "image_url"
        case abv
        case firstBrewed = "first_brewed"
        case foodPairing = "food_pairing"
        case brewersTips = "brewers_tips"
    }
}

extension Beer: Displayable {
    var idLabelText: String {
        "#\(id)"
    }

    var nameLabelText: String {
        name
    }

    var taglineLabelText: String {
        tagline
    }

    var descriptionLabelText: String {
        description
    }
    
    var getImageUrl: String {
        imageUrl
    }
    
    var getFirstBrewedText: String {
        firstBrewed
    }
    
    var getAbv: String {
        "\(abv)"
    }
    
    var getFoodPairing: [String] {
        foodPairing
    }
    
    var getBrewersTips: String {
        brewersTips
    }
}
