//
//  Damage.swift
//  DBServerTest
//
//  Created by Rafael Goncalves on 26/06/19.
//  Copyright © 2019 Novus Produtos Eletronicos Ltda. All rights reserved.
//

import Foundation

struct Damage: Codable {
    var double_damage_from : [Type]
    var double_damage_to : [Type]
    var half_damage_from : [Type]
    var half_damage_to : [Type]
    var no_damage_from : [Type]
    var no_damage_to : [Type]
}

