//
//  PokemonDetail.swift
//  DBServerTest
//
//  Created by Rafael Goncalves on 26/06/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import Foundation

struct PokemonDetail: Codable{
    
    var abilities : [Ability]
    var base_experience : Int
    var forms : [Type]
    var game_indices: [GameIndices]
    var height : Int
    var held_items : [Type]
    var id : Int
    var is_default : Bool
    var location_area_encounters : String
    var moves : [Type]
    var name : String
    var order : Int
    var species : Type
    var sprites : Sprite
    var stats : Stat
    var types : Types
    var weight : Int

    init(abilities: [Ability], base_experience: Int, forms: [Type], game_indices: [GameIndices] , height: Int, held_items: [Type], id: Int, is_default: Bool, location_area_encounters: String, moves: [Type], name: String, order: Int, species: Type, sprites: Sprite, stats: Stat, types: Types, weight: Int){
        
        self.abilities = abilities
        self.base_experience = base_experience
        self.forms = forms
        self.game_indices = game_indices
        self.height = height
        self.held_items = held_items
        self.id = id
        self.is_default = is_default
        self.location_area_encounters = location_area_encounters
        self.moves = moves
        self.name = name
        self.order = order
        self.species = species
        self.sprites = sprites
        self.stats = stats
        self.types = types

        self.weight = weight

    }
}

struct Ability : Codable{
    var ability : [Type]
    
    var is_hidden : Bool
    var slot : Int
    
}
struct Sprite : Codable{
    
}
struct Stat : Codable{
    
}

struct Types : Codable{
    
}

