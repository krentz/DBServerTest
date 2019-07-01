//
//  PokemonList.swift
//  DBServerTest
//
//  Created by Rafael Goncalves on 26/06/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import Foundation

struct PokemonList{
    
    var damage_relations : Any
    var game_indices : [GameIndices]?
    var generation : Type?
    var id : Int?
    var move_damage_class : Type?
    var moves : [Type]?
    var name : String?
    var names : [NameLanguage]?
    var pokemon : [String]?
    
    init(damage_relations: Any, game_indices: [GameIndices], generation: Type, id: Int, move_damage_class: Type, moves: [Type], name: String, names: [NameLanguage], pokemon: [String]) {
        self.damage_relations = damage_relations
        self.game_indices = game_indices
        self.generation = generation
        self.id = id
        self.move_damage_class = move_damage_class
        self.moves = moves
        self.name = name
        self.names = names
        self.pokemon = pokemon
    }
    
}

