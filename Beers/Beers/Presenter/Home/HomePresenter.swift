//
//  HomePresenter.swift
//  Beers
//
//  Created by Mobile Team on 20/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation

protocol HomePresenter {
    func fetchBeers()
}

func createHomePresenter(withView view: HomeView) -> HomePresenter {
    return HomePresenterImpl(view: view)
}
