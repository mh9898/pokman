//
//  Pokemon.swift
//  Pokeman
//
//  Created by Michael Harari on 07/05/2020.
//  Copyright © 2020 mh. All rights reserved.
//

import Foundation

class Pokemon{
    private var _name: String!
    private var _pokedexid: Int!
    
    var name: String{
        return _name
    }
    
    var pokedexid: Int{
        return _pokedexid
    }
    
    init(name: String, pokedexid:Int) {
        _name = name
        _pokedexid = pokedexid
    }
}
