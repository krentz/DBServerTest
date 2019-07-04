//
//  ParseAPI.swift
//  DBServerTest
//
//  Created by Rafael Goncalves on 02/07/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import Foundation

typealias ParseReponseDict = [String: Any]

class ParseAPI{
    
    static let shared = ParseAPI()

    func parsePokemonTypeList(response: ParseReponseDict) -> PokemonType?{
        
        guard let count = response["count"] as? Int,
            let results = response["results"] as? [[String: Any]]
            else {
                return nil
        }
        let next = response["next"] as? Int ?? 0
        let previus = response["previous"] as? Int ?? 0
        
        var resultsArray : [PokemonTypeStructure] = [PokemonTypeStructure]()
        for result in results{
            resultsArray.append(PokemonTypeStructure(name: (result as AnyObject)["name"] as! String,
                                                     url: (result as AnyObject)["url"] as! String))
        }
        
        return PokemonType(count: count, next: next, previous: previus, results: resultsArray)
    }
    
    
    func parsePokemonList(response: ParseReponseDict) -> [PokemonTypeStructure]?{
        
        guard let pokemons = response["pokemon"] as?  [Any]
            else {
                return nil
        }
        
        var resultsArray : [PokemonTypeStructure] = [PokemonTypeStructure]()
        for pokemon in pokemons{
            resultsArray.append(PokemonTypeStructure(name: (((pokemon as AnyObject)["pokemon"] as AnyObject)["name"] as! String),
                                                     url: ((pokemon as AnyObject)["pokemon"] as AnyObject)["url"] as! String))
        }
        
        return resultsArray
    }
    
    
    func parsePokemon(response: ParseReponseDict) -> PokemonDetail?{
        
        guard let name = response["name"] as? String,
            let id = response["id"] as? Int,
            let sprites = response["sprites"] as? [String:Any],
            let urlImage = sprites["front_default"] as? String,
            let height = response["height"] as? Int,
            let weight = response["weight"] as? Int,
            let abilities = response["abilities"] as? [Any]
            else {
                return nil
        }
        
        var abilitiesArray : [String] = [String]()
        for ability in abilities{
            abilitiesArray.append(((ability as AnyObject)["ability"] as AnyObject)["name"] as! String)
        }
        
        return PokemonDetail(id: id, name: name, urlImage: urlImage, height: height, weight: weight, abilities: abilitiesArray)
    }
    
}
