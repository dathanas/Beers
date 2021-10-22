//
//  TempViewController.swift
//  Beers
//
//  Created by Mobile Team on 29/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import UIKit

class TempViewController: UIViewController {


    @IBOutlet weak var densityView: UIBeerDensityView!
    @IBOutlet weak var colorfulDensityView: UIColorfulBeerDensityView!
    @IBOutlet weak var transparentDensity: UITransparentBeerDensityView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        change()
    }
    
    func change() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            //let values: [BeerAlcoholDensity?] = [nil, .light, .normal, .strong, .extraStrong]
            //self.densityView.density = values.randomElement() ?? nil
            let number = Double.random(in: 0.0...56.0)
            self.densityView.abv = number
            self.colorfulDensityView.abv = number
            self.transparentDensity.abv = number
            
            self.change()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
