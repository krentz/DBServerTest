//
//  PokemonType.swift
//  DBServerTest
//
//  Created by Rafael Goncalves on 26/06/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import Foundation


struct PokemonType: Codable{
    
    var count : Int
    var next : Int?
    var previous : Int?
    var results : [Type]
    
    init(count: Int, next: Int, previous: Int, results: [Type]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

