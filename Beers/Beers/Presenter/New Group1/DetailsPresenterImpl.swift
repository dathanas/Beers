//
//  DetailsPresenterImpl.swift
//  Beers
//
//  Created by Mobile Team on 20/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation

class DetailsPresenterImpl: DetailsPresenter {
    private let view: DetailsView

    private let service = BeerService.shared
    
    init(view: DetailsView) {
        self.view = view

    }
    
    func getBeerDetails(forID beerID: Int) {
        service.getBeer(by: beerID) { (beer, error) in
            self.view.didGetBeer(beer!)
        }
    }
}
