//
//  PokemonDetailViewController.swift
//  DBServerTest
//
//  Created by Rafael Goncalves on 26/06/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    var pokemonURL : String = ""
    var pokemonModel : PokemonModel?
    
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
            
            self.pokemonModel = pokemonModel
           
        })
    }
    
}
