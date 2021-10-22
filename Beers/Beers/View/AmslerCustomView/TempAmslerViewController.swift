//
//  TempAmslerViewController.swift
//  Beers
//
//  Created by Mobile Team on 2/11/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import UIKit

class TempAmslerViewController: UIViewController {

    @IBOutlet weak var amslerView: UIAmslerGridView!
    var point: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.amslerView.lineWidth = .normal
        self.amslerView.shape = .square
        self.amslerView.artifactType = .distortion
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture(_:)))
        amslerView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        point = sender.location(in: amslerView)
        if amslerView.getTapPositionBy(point) {
            amslerView.tapPoint = point
            print("\(amslerView.tapPoint ?? CGPoint(x: 0,y: 0)) && \(amslerView.artifactType ?? .darkened)")
            if amslerView.artifactType == .ellipsis {
                amslerView.addDistortionView(amslerView.ellipsisView, at: point)
            } else if amslerView.artifactType == .darkened {
                amslerView.addDistortionView(amslerView.darkenedView, at: point)
            } else if amslerView.artifactType == .distortion {
                amslerView.addDistortionView(amslerView.distortionView, at: point)
            }
        }
    }
}
