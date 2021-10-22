//
//  DetailsPresenter.swift
//  Beers
//
//  Created by Mobile Team on 20/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation

protocol DetailsPresenter {
    func getBeerDetails(forID beerID: Int)
}

func createDetailsPresenter(view: DetailsView) -> DetailsPresenter {
    return DetailsPresenterImpl(view: view)
}
