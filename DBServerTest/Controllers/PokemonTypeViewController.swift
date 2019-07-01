//
//  ViewController.swift
//  DBServerTest
//
//  Created by Rafael Goncalves on 26/06/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import UIKit

class PokemonTypeViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.isHidden = true
        }
    }
    
    var pokemonTypeList : PokemonType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Pokemon Types"
   
        self.loadPokemonTypeList(url: "https://pokeapi.co/api/v2/type/")
    }

    func loadPokemonTypeList(url: String?){
        Service.shared.loadPokemonTypeList(url: url){ (response) in
            switch response{
            case .success(let model):
                
                self.resultModel = model
                
                DispatchQueue.main.async {
                
                    self.tableView.reloadData()
                
                    if self.tableView.isHidden == true {
                        UIView.transition(with:  self.tableView,
                                        duration: 0.5,
                                        options: .transitionCrossDissolve,
                                        animations: {
                                            self.tableView.isHidden = false
                                    })
                    }
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
    
    var requestPokedex = Service()
    var resultModel: PokemonType?
    var resultCount = 0
    var pokemons = [PokemonModel]()
    var imagePokemons = [Data]()
    
    enum PokemonResponse{
        case success(model: PokemonModel)
        case serverError(description: ServerError)
        case timeOut(description: ServerError)
        case noConnection(description: ServerError)
        case invalidResponse
    }
    
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "pokemonList") {
            let vc = segue.destination as! PokemonListViewController
            vc.pokemonsType = sender as? PokemonTypeStructure
        }
    }
}

extension PokemonTypeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "pokemonList", sender: self.resultModel?.results[indexPath.row])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


extension PokemonTypeViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let typeName = self.resultModel?.results[indexPath.row].name{
            cell.textLabel?.text = "\(String(describing: typeName))"
        }
        
        //remove extra separator
        self.tableView.tableFooterView = UIView()
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count =  self.resultModel?.count {
            return count
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
