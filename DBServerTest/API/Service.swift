//
//  Service.swift
//  DBServerTest
//
//  Created by Rafael Goncalves on 26/06/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import Foundation
class Service{
    
    static let shared = Service()
    
    func getPokemonTypesList(completion: @escaping ((PokemonType) -> Void)){
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/type/") else{ return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                NotificationCenter.default.post(name: .connectionError, object: "Please check your internet and try again!")
            }
            
            guard let data = data else {return NotificationCenter.default.post(name: .connectionError, object: "Data error. Please, try again.") }//notification error no data}
            
            do {
                let jsonDecoder = JSONDecoder()
                let json = try jsonDecoder.decode(PokemonType.self, from: data)
                completion(json)
            } catch{
                NotificationCenter.default.post(name: .connectionError, object: "Please check your internet and try again!")
            }
            }.resume()
    }
    
    
    func getPokemonList(url: String, completion: @escaping ((PokemonList) -> Void)){
        
        guard let url = URL(string: url) else{ return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                NotificationCenter.default.post(name: .connectionError, object: "Please check your internet and try again!")
            }
            
            guard let data = data else {return NotificationCenter.default.post(name: .connectionError, object: "Data error. Please, try again.") }//notification error no data}
            
            do {
                let jsonDecoder = JSONDecoder()
                let json = try jsonDecoder.decode(PokemonList.self, from: data)
                completion(json)
            } catch{
                NotificationCenter.default.post(name: .connectionError, object: "Please check your internet and try again!")
            }
            }.resume()
    }
    
    
    
}
