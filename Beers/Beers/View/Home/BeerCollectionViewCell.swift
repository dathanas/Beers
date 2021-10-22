//
//  BeerCollectionViewCell.swift
//  Beers
//
//  Created by Mobile Team on 13/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import UIKit

class BeerCollectionViewCell: UICollectionViewCell {

    @IBOutlet
    var beerNameLabel: UILabel!
    
    @IBOutlet
    var beerImage: UIImageView!
    
    @IBOutlet
    var labelView: UIView!
    
    @IBOutlet
    var rootView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rootView.layer.cornerRadius = 8.0
        rootView.layer.borderWidth = 0.1
        rootView.layer.borderColor = UIColor.lightGray.cgColor

        rootView.layer.shadowColor = UIColor.gray.cgColor
        rootView.layer.shadowRadius = 6.0
        rootView.layer.shadowOpacity = 0.8
        
        beerImage.layer.backgroundColor = UIColor.white.cgColor
    }

    
    func willDisplay(beer: Displayable) {
        beerNameLabel.text = beer.nameLabelText
        setImage(from: beer.getImageUrl)
    }
    
    func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        let requestId = UUID()
        beerImage.image =  UIImage(named: "imageNotAvailable")
        
        // just not to cause a deadlock in UI!
        DispatchQueue.global(qos: .background).async {
            let id = requestId
            guard let imageData = try? Data(contentsOf: imageURL) else { return }

            if id == requestId {
                let image = UIImage(data: imageData)
                
                DispatchQueue.main.async {
                    self.beerImage.image = image
                }
            }
        }
    }
}
