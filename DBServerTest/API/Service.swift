//
//  Service.swift
//  DBServerTest
//
//  Created by Rafael Goncalves on 26/06/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import Foundation
import Alamofire

typealias ParseReponseDict = [String: Any]
typealias PokemonSpriteDict = [String: Any]
typealias AbilitiesDict = [String: Any]

typealias PokedexCompletion = (_ response: PokedexResponse) -> Void
typealias PokedexListCompletion = (_ response: PokemonListResponse) -> Void

enum PokedexResponse{
    case success(model: PokemonType)
    case serverError(description: ServerError)
    case timeOut(description: ServerError)
    case noConnection(description: ServerError)
    case invalidResponse
}
enum PokemonListResponse{
    case success(model: [Type])
    case serverError(description: ServerError)
    case timeOut(description: ServerError)
    case noConnection(description: ServerError)
    case invalidResponse
}

struct ServerError{
    var description: String
    var errorCode: Int
}
enum PokemonResponse{
    case success(model: PokemonModel)
    case serverError(description: ServerError)
    case timeOut(description: ServerError)
    case noConnection(description: ServerError)
    case invalidResponse
}


enum JSONError: String, Error {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}


class Service{
    
    static let shared = Service()
    
    let alamofireManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10000
        configuration.timeoutIntervalForResource = 10000
        return Session(configuration: configuration)
    }()
    
    func loadPokemonTypeList(url:String?, completion: @escaping PokedexCompletion){
        
        alamofireManager.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{ (response) in
                
                let statusCode = response.response?.statusCode
                switch response.result{
               
                case .success(let value):
                    //Json com retorno
                    let resultValue = value as? [String: Any]
                    if statusCode == 404 {
                        if let description = resultValue?["detail"] as? String{
                            let error = ServerError(description: description, errorCode: statusCode!)
                            completion(.serverError(description: error))
                        }
                    }
                    else if statusCode == 200{
                        if let dict = resultValue, let model = self.parsePokemonTypeList(response: dict) {
                            completion(.success(model: model))
                        } else {
                            completion(.invalidResponse)
                        }
                    }
                case .failure(let error):
                    //Status de erro
                    let errorCode = error._code
                    if errorCode == -1009{
                        let erro = ServerError(description: error.localizedDescription, errorCode: errorCode)
                        completion(.noConnection(description: erro))
                    }
                    else if errorCode == -1001{
                        let erro = ServerError(description: error.localizedDescription, errorCode: errorCode)
                        completion(.timeOut(description: erro))
                    }
                }
        }
    }
    
    
    func parsePokemonTypeList(response: ParseReponseDict) -> PokemonType?{
        
        guard let count = response["count"] as? Int,
            let results = response["results"] as? [[String: Any]]
            else {
                return nil
        }
        let next = response["next"] as? Int ?? 0
        let previus = response["previous"] as? Int ?? 0
        
        
        var resultsArray : [PokemonTypeStructure] = [PokemonTypeStructure]()
        for i in 0...results.count-1{
            resultsArray.append(PokemonTypeStructure(name: (results[i] as AnyObject)["name"] as! String,
                                     url: (results[i] as AnyObject)["url"] as! String))
        }
        
        return PokemonType(count: count, next: next, previous: previus, results: resultsArray)
    }
    
    
    func parsePokemonList(response: ParseReponseDict) -> [Type]?{
        
//        guard let damage = response["damage_relations"],
//            let id = response["id"] as? Int,
//            let name = response["name"] as? String,
         guard   let pokemons = response["pokemon"] as?  [Any]
            
            //            let urlImage = sprites["front_default"] as? String,
//            let height = response["height"] as? Int,
//            let weight = response["weight"] as? Int,
//            let abilitiesDict = response["abilities"] as? [Any]
            else {
                return nil
        }

        var resultsArray : [Type] = [Type]()
        for i in 0...pokemons.count-1{
            resultsArray.append(Type(name: (((pokemons[i] as AnyObject)["pokemon"] as AnyObject)["name"] as! String),
                                     url: ((pokemons[i] as AnyObject)["pokemon"] as AnyObject)["url"] as! String))
        }
        
        
        return resultsArray
        
        //((pokemons[i] as AnyObject)["pokemon"] as AnyObject)["name"]
        //  http://pokeapi.co/api/v2/pokemon/ (id)

        
        
//        return PokemonList(damage_relations: damage, game_indices: [], generation: Type(name: "", url: ""), id: id, move_damage_class: Type(name: "", url: ""), moves: [Type(name: "", url: "")], name: name, names: [], pokemon: resultsArray)
//
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
    
    func loadPokemonList(url: String, completion: @escaping PokedexListCompletion){
        
        alamofireManager.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{ (response) in
            
            let statusCode = response.response?.statusCode
            switch response.result{
                
            case .success(let value):
                //Json com retorno
                let resultValue = value as? [String: Any]
                if statusCode == 404 {
                    if let description = resultValue?["detail"] as? String{
                        let error = ServerError(description: description, errorCode: statusCode!)
                        completion(.serverError(description: error))
                    }
                }
                else if statusCode == 200{
                    if let dict = resultValue, let model = self.parsePokemonList(response: dict) {
                        completion(.success(model: model))
                    } else {
                        completion(.invalidResponse)
                    }
                }
            case .failure(let error):
                //Status de erro
                let errorCode = error._code
                if errorCode == -1009{
                    let erro = ServerError(description: error.localizedDescription, errorCode: errorCode)
                    completion(.noConnection(description: erro))
                }
                else if errorCode == -1001{
                    let erro = ServerError(description: error.localizedDescription, errorCode: errorCode)
                    completion(.timeOut(description: erro))
                }
            }
        }
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

