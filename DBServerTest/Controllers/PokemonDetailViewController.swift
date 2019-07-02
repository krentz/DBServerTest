//
//  PokemonDetailViewController.swift
//  DBServerTest
//
//  Created by Rafael Goncalves on 26/06/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import UIKit
import Kingfisher

class PokemonDetailViewController: UIViewController {

    var pokemonURL : String = ""
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var abilities: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.parsePokemonTypesListResponse()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Pokemon"
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func parsePokemonTypesListResponse(){
        
        Service.shared.loadPokemonDetail(url: pokemonURL){ response in
            switch response{
            case .success(let pokemonModel):
                
                DispatchQueue.main.async {
                    self.picture.loadImage(url: pokemonModel.urlImage)
                    self.name.text = pokemonModel.name
                    self.height.text = "\(pokemonModel.height)"
                    self.weight.text = "\(pokemonModel.weight)"
                    self.abilities.text = "\(pokemonModel.weight)"
                }
                
            case .serverError(let description):
                print(description)
                self.showAlert(title: "server error" , message:  "error", in: self)
            case .timeOut(let description):
                print(description)
                self.showAlert(title: "timeout" , message:  "error", in: self)
            case .noConnection(let description):
                print(description)
                self.showAlert(title: "No connection" , message:  "error", in: self)
            case .invalidResponse:
                self.showAlert(title: "Invalid Response" , message:  "error", in: self)
                print("Invalid Response")
            }
        }
        
        Service.shared.loadPokemonDetail(url: pokemonURL, completion: { pokemonModel in
            
            
        })
    }
    
    
    
}
