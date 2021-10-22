//
//  TitleTableViewCell.swift
//  Beers
//
//  Created by Mobile Team on 21/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import UIKit

class TitleTableViewCell: UITableViewCell, AnyBeerCell {

    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerTaglineLabel: UILabel!
    
    private var presenter: DetailsPresenter!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        presenter = createDetailsPresenter(view: self)
    }

    func willDisplay(by beerID: Int) {
        presenter.getBeerDetails(forID: beerID)
    }
    
}

extension TitleTableViewCell: DetailsView {
    func getImage(from url: String){
        //Do nothing
    }
    
    func didGetBeer(_ beer: Beer) {
        beerNameLabel.text = beer.nameLabelText
        beerTaglineLabel.text = beer.taglineLabelText
    }
}
