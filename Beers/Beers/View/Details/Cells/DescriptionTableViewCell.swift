//
//  DescriptionTableViewCell.swift
//  Beers
//
//  Created by Mobile Team on 21/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell, AnyBeerCell {

    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
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

extension DescriptionTableViewCell: DetailsView {
    func getImage(from url: String) {
        //do nothing
    }
    
    func didGetBeer(_ beer: Beer) {
        beerDescriptionLabel.text = beer.descriptionLabelText
    }

    
}
