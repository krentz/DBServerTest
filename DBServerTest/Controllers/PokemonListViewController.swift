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
    
    var pokemonList : PokemonList?
    var pokemonsType: Type?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Type"
       self.navigationController?.navigationBar.topItem?.title = ""
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showError(_:)), name: .connectionError, object: nil)
        
        self.parsePokemonTypesListResponse()
    }
    
    @objc func showError(_ notification: NSNotification){
        self.showAlert(title: "Connection error" , message:  notification.object as! String, in: self)
    }
    
    func parsePokemonTypesListResponse(){
        Service.shared.getPokemonList(url: pokemonsType!.url, completion: { pokemonList in
            
            self.pokemonList = pokemonList
            
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
        })
    }
    
    
}

extension PokemonListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if let typeName = self.pokemonList?.pokemon[indexPath.row].pokemon.name{
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
        
        if let count =  self.pokemonList?.pokemon.count {
            return count
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
