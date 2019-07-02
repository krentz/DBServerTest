//
//  PokemonList.swift
//  DBServerTest
//
//  Created by Rafael Goncalves on 26/06/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import UIKit

class PokemonListViewController :UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    var pokemonList : [Type] = [Type]()
    var pokemonsType: PokemonTypeStructure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Type"
        self.navigationController?.navigationBar.topItem?.title = ""
        
        self.loadPokemonTypeList()
    }
    
    func loadPokemonTypeList(){
        Service.shared.loadPokemonList(url: pokemonsType!.url){ (response) in
            switch response{
            case .success(let model):
                
                self.pokemonList = model
                
                DispatchQueue.main.async {
                    self.tableView.showTableViewWithAnimation()
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
    
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "pokemonDetail") {
            let vc = segue.destination as! PokemonDetailViewController
            if let pokemon = sender as? String {
                vc.pokemonURL = pokemon
            }
        }
    }
}

extension PokemonListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "pokemonDetail", sender:  self.pokemonList[indexPath.row].url)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension PokemonListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
            cell.textLabel?.text = "\(String(describing: self.pokemonList[indexPath.row].name))"
        
        //remove extra separator
        self.tableView.tableFooterView = UIView()
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if let count =  self.pokemonList?.pokemon?.count {
//            return count
//        }
        
        return  self.pokemonList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
