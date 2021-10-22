//
//  ImageTableViewCell.swift
//  Beers
//
//  Created by Mobile Team on 21/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var beerImageView: UIImageView!
    
    private var presenter: DetailsPresenter!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        presenter = createDetailsPresenter(view: self)
        
        beerImageView.layer.masksToBounds = false
        beerImageView.layer.cornerRadius = 160
        beerImageView.clipsToBounds = true
        
        beerImageView.layer.borderWidth = 1
        beerImageView.layer.borderColor = UIColor.lightGray.cgColor

        rootView.layer.shadowColor = UIColor.gray.cgColor
        rootView.layer.shadowRadius = 10
        rootView.layer.shadowOpacity = 0.8
        
        beerImageView.layer.backgroundColor = UIColor.white.cgColor
    }

    func willDisplay(by beerID: Int) {
        presenter.getBeerDetails(forID: beerID)
    }
}


extension ImageTableViewCell: DetailsView {
    func getImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        let requestId = UUID()
        beerImageView.image = UIImage(named: "imageNotAvailable")
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global(qos: .background).async {
            let id = requestId
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            if id == requestId {
                let image = UIImage(data: imageData)
                
                DispatchQueue.main.async {
                    self.beerImageView.image = image
                }
            }
        }
    }
    
    func didGetBeer(_ beer: Beer) {
        getImage(from: beer.imageUrl)
    }

}
