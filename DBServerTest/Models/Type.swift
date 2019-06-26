//
//  Type.swift
//  DBServerTest
//
//  Created by Rafael Goncalves on 26/06/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import Foundation

struct Type : Codable{
    var name : String
    var url : String
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
