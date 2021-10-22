//
//  HomeView.swift
//  Beers
//
//  Created by Mobile Team on 20/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation

protocol HomeView {
    func didFindAllBeers(_ beers: [Beer]?, error: BeerService.RequestError?)
}
