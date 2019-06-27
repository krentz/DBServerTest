//
//  Service.swift
//  DBServerTest
//
//  Created by Rafael Goncalves on 26/06/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import Foundation

typealias ParseReponseDict = [String: Any]
typealias PokemonSpriteDict = [String: Any]
typealias AbilitiesDict = [String: Any]

enum JSONError: String, Error {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}


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
    
    func parsePokemon(response: ParseReponseDict) -> PokemonModel?{
        
        guard let name = response["name"] as? String,
            let id = response["id"] as? Int,
            let sprites = response["sprites"] as? PokemonSpriteDict,
            let urlImage = sprites["front_default"] as? String,
            let height = response["height"] as? Int,
            let weight = response["weight"] as? Int,
            let abilitiesDict = response["abilities"] as? [Any]
            else {
                return nil
        }
        var abilitiesArray : [String] = [String]()
        for i in 0...abilitiesDict.count-1{
            abilitiesArray.append(((abilitiesDict[i] as AnyObject)["ability"] as AnyObject)["name"] as! String)
        }
        
        return PokemonModel(id: id, name: name, urlImage: urlImage, height: height, weight: weight, abilities: abilitiesArray)
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
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }catch{
                NotificationCenter.default.post(name: .connectionError, object: "Please check your internet and try again!")
            }
        }.resume()
    }
    
    func getPokemonDetail(url: String, completion: @escaping ((PokemonModel) -> Void)){
        
        guard let url = URL(string: url) else{ return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                NotificationCenter.default.post(name: .connectionError, object: "Please check your internet and try again!")
            }
            
            guard let data = data else {return NotificationCenter.default.post(name: .connectionError, object: "Data error. Please, try again.") }//notification error no data}
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let model = self.parsePokemon(response: json) {
                        completion(model)
                        
                    } else {
                       throw JSONError.ConversionFailed
                    }
                }
                else{
                    throw JSONError.ConversionFailed
                }
                
                
            } catch let error as JSONError {
                print(error.rawValue)
            } catch let error as NSError {
                print(error.debugDescription)
            }catch{
                NotificationCenter.default.post(name: .connectionError, object: "Please check your internet and try again!")
            }
        }.resume()
    }
    
    
}

