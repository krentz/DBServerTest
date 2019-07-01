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
      
        self.navigationItem.title = "Pokemon"
        
        self.navigationController?.navigationBar.topItem?.title = ""
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showError(_:)), name: .connectionError, object: nil)
        
        self.parsePokemonTypesListResponse()
        
    }
    
    @objc func showError(_ notification: NSNotification){
        self.showAlert(title: "Connection error" , message:  notification.object as! String, in: self)
    }
    
    func parsePokemonTypesListResponse(){
        Service.shared.getPokemonDetail(url: pokemonURL, completion: { pokemonModel in
            
            DispatchQueue.main.async {
                self.picture.loadImage(url: pokemonModel.urlImage)
                self.name.text = pokemonModel.name
                self.height.text = "\(pokemonModel.height)"
                self.weight.text = "\(pokemonModel.weight)"
                self.abilities.text = "\(pokemonModel.weight)"
            }
        })
    }
    
}
