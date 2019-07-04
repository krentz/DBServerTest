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
            case .success(let pokemonDetail):
                DispatchQueue.main.async {
                    self.picture.loadImage(url: pokemonDetail.urlImage)
                    self.name.text = pokemonDetail.name
                    self.height.text = "\(pokemonDetail.height)"
                    self.weight.text = "\(pokemonDetail.weight)"
                    self.abilities.text = "\(pokemonDetail.weight)"
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
    }
}
