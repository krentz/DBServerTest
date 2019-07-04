//
//  Service.swift
//  DBServerTest
//
//  Created by Rafael Goncalves on 26/06/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import Foundation
import Alamofire

typealias PokedexCompletion = (_ response: PokedexResponse) -> Void
typealias PokedexListCompletion = (_ response: PokemonListResponse) -> Void
typealias PokemonModelCompletion = (_ response: PokemonResponse) -> Void

enum PokedexResponse{
    case success(model: PokemonType)
    case serverError(description: ServerError)
    case timeOut(description: ServerError)
    case noConnection(description: ServerError)
    case invalidResponse
}
enum PokemonListResponse{
    case success(model: [PokemonTypeStructure])
    case serverError(description: ServerError)
    case timeOut(description: ServerError)
    case noConnection(description: ServerError)
    case invalidResponse
}
enum PokemonResponse{
    case success(model: PokemonDetail)
    case serverError(description: ServerError)
    case timeOut(description: ServerError)
    case noConnection(description: ServerError)
    case invalidResponse
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
                let resultValue = value as? [String: Any]
                if statusCode == 404 {
                    if let description = resultValue?["detail"] as? String{
                        let error = ServerError(description: description, errorCode: statusCode!)
                        completion(.serverError(description: error))
                    }
                }
                else if statusCode == 200{
                    if let dict = resultValue, let model = ParseAPI.shared.parsePokemonTypeList(response: dict) {
                        completion(.success(model: model))
                    } else {
                        completion(.invalidResponse)
                    }
                }
            case .failure(let error):
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
    
    func loadPokemonList(url: String, completion: @escaping PokedexListCompletion){
        alamofireManager.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{ (response) in
            
            let statusCode = response.response?.statusCode
            switch response.result{
                
            case .success(let value):
                let resultValue = value as? [String: Any]
                if statusCode == 404 {
                    if let description = resultValue?["detail"] as? String{
                        let error = ServerError(description: description, errorCode: statusCode!)
                        completion(.serverError(description: error))
                    }
                }
                else if statusCode == 200{
                    if let dict = resultValue, let model = ParseAPI.shared.parsePokemonList(response: dict) {
                        completion(.success(model: model))
                    } else {
                        completion(.invalidResponse)
                    }
                }
            case .failure(let error):
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
    
    func loadPokemonDetail(url: String, completion: @escaping PokemonModelCompletion){
        alamofireManager.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON{ (response) in
            
            let statusCode = response.response?.statusCode
            switch response.result{
                
            case .success(let value):
                let resultValue = value as? [String: Any]
                if statusCode == 404 {
                    if let description = resultValue?["detail"] as? String{
                        let error = ServerError(description: description, errorCode: statusCode!)
                        completion(.serverError(description: error))
                    }
                }
                else if statusCode == 200{
                    if let dict = resultValue, let model = ParseAPI.shared.parsePokemon(response: dict) {
                        completion(.success(model: model))
                    } else {
                        completion(.invalidResponse)
                    }
                }
            case .failure(let error):
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
}

