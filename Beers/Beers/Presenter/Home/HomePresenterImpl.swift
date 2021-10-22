//
//  HomePresenterImpl.swift
//  Beers
//
//  Created by Mobile Team on 20/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation

class HomePresenterImpl : HomePresenter {
    
    private let service = BeerService.shared
    
    private let view: HomeView
    
    init(view: HomeView) {
        self.view = view
    }
    
    func fetchBeers() {
        service.fetchBeers { (beers, error) in
            self.view.didFindAllBeers(beers, error: error)
        }
    }
}
