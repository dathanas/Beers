//
//  DetailsTableViewController.swift
//  Beers
//
//  Created by Mobile Team on 21/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    
    @IBOutlet weak var beerTitleNavItem: UINavigationItem!
    var beerID: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beerTitleNavItem.title = "#\(beerID ?? 0)"
        
        tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "imageCell")
        tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "titleCell")
        tableView.register(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "descriptionCell")
        tableView.register(UINib(nibName: "DetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "detailsCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
        } else if indexPath.row == 1 {
            return tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
        } else if indexPath.row == 2 {
            return tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath)
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard let imageCell = cell as? ImageTableViewCell else { return }
            imageCell.willDisplay(by: beerID)
        } else {
            guard let beerCell = cell as? AnyBeerCell else { return }
            beerCell.willDisplay(by: beerID)
        }
    }
}
