//
//  BeersCollectionViewController.swift
//  Beers
//
//  Created by Mobile Team on 14/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "beerCollectionViewCell"

class BeersCollectionViewController: UICollectionViewController {
    
    var items: [Displayable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "BeerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        createHomePresenter(withView: self).fetchBeers()
    }
    
    //show product
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBeerDetails" {
            guard let beerDetailsVC = segue.destination as? DetailsTableViewController, let beer = sender as? Beer else {
                return
            }
            beerDetailsVC.beerID = beer.id
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BeerCollectionViewCell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        
        if let beerCell = cell as? BeerCollectionViewCell {
            cell.alpha = 0
            UIView.animate(withDuration: 0.8) {
                cell.alpha = 1
            }
            
            beerCell.willDisplay(beer: item)
        }
    }

}

extension BeersCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let beer = items[indexPath.row]
        performSegue(withIdentifier: "showBeerDetails", sender: beer)
    }
}

extension BeersCollectionViewController: HomeView {
    func didFindAllBeers(_ beers: [Beer]?, error: BeerService.RequestError?) {
        if error == nil {
            self.items = beers ?? []
            self.collectionView.reloadData()
        } else {
            print(error)
        }
    }
}
