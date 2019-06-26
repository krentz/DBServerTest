//
//  PokemonDetailViewController.swift
//  DBServerTest
//
//  Created by Rafael Goncalves on 26/06/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var pokemonDetail : PokemonDetail?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //nome, foto (campo front_default), altura, peso e nome das habilidades
    
}

extension PokemonDetailViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.performSegue(withIdentifier: "pokemonList", sender: self.pokemonDetail?.results[indexPath.row])
//    }
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 80
    //    }
}

extension PokemonDetailViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
//        if let typeName = self.pokemonDetail?.results[indexPath.row].name{
//            cell.textLabel?.text = "\(String(describing: typeName))"
//        }
        
        
         cell.textLabel?.text = "oi"
        
        //remove extra separator
        self.tableView.tableFooterView = UIView()
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if let count =  self.pokemonDetail?.count {
//            return count
//        }
        
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
