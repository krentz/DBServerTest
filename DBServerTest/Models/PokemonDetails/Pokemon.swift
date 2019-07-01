//
//  Pokemon.swift
//  DBServerTest
//
//  Created by Rafael Goncalves on 26/06/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import Foundation

struct  Pokemon: Codable {
    var pokemon : Type
    var slot : Int
}

struct PokemonNamesStructure{
    var pokemon : [Any]
    var slot : Int
}

struct PokemonListNames {
    var name : String?
    var id : Int?
}
