//
//  BeerService.swift
//  Beers
//
//  Created by Mobile Team on 15/10/20.
//  Copyright © 2020 Despina. All rights reserved.
//

import Foundation
import Alamofire

class BeerService {
    typealias BeersCallback = (([Beer]?, RequestError?) -> ())
    
    typealias BeerCallback = ((Beer?, RequestError?) -> ())
    
    typealias Beers = [Beer]

    
    enum RequestError: Error {
        case invalidData
        case noInternet
        case noResponse
    }
    
    public static let shared = BeerService()
    
    private init() { }
    
    func fetchBeers(_ completion: @escaping BeersCallback) {
        AF.request("https://api.punkapi.com/v2/beers")
            .validate()
            .responseDecodable(of: Beers.self) { (response) in
                guard let beers = response.value else {
                    DispatchQueue.main.async {
                        completion(nil, .noResponse)
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(beers, nil)
                }
        }
    }
    
    func getBeer (by id: Int, _ completion: @escaping BeerCallback) {
        AF.request("https://api.punkapi.com/v2/beers/\(id)")
            .validate()
            .responseDecodable(of: Beers.self) { (response) in
                guard let beer = response.value?.first else {
                    DispatchQueue.main.async {
                        completion(nil, .noResponse)
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(beer, nil)
                }
        }
    }
}
