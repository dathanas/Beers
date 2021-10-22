//
//  DetailsTableViewCell.swift
//  Beers
//
//  Created by Mobile Team on 21/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell, AnyBeerCell {

    @IBOutlet weak var firstBrewedTitleLabel: UILabel!
    @IBOutlet weak var abvTitleLabel: UILabel!
    @IBOutlet weak var foodPairingLabel: UILabel!
    @IBOutlet weak var brewersTipsLabel: UILabel!
    @IBOutlet weak var foodPairingTitle: UILabel!
    @IBOutlet weak var brewersTipsTitle: UILabel!
    //@IBOutlet weak var abvLabel: UILabel!
    @IBOutlet weak var densityView: UIBeerDensityView!
    @IBOutlet weak var firstBrewedLabel: UILabel!
    
    
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

extension DetailsTableViewCell: DetailsView {
    func getImage(from url: String) {
        //do nothing
    }
    
    func didGetBeer(_ beer: Beer) {
        firstBrewedLabel.text = beer.getFirstBrewedText
        //abvLabel.text = beer.getAbv
        densityView.abv = beer.abv
        foodPairingTitle.text = "Food Pairing"
        
        var foodPairingText = ""
        
        for food in beer.getFoodPairing {
            foodPairingText += "\(food) \n"
        }
        
        foodPairingLabel.text = foodPairingText
        
        brewersTipsTitle.text = "Brewers Tips"
        brewersTipsLabel.text = beer.getBrewersTips
    }
    
    
}
