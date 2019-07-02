//
//  UITableView+animations.swift
//  DBServerTest
//
//  Created by Rafael Krentz Gonçalves on 7/1/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import UIKit

extension UITableView{
    func showTableViewWithAnimation(){
        UIView.transition(with:  self,
                          duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.reloadData()
                            self.isHidden = false
        })
    }
}

