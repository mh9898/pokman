//
//  PokeCell.swift
//  Pokeman
//
//  Created by Michael Harari on 07/05/2020.
//  Copyright © 2020 mh. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    var pokemon: Pokemon!
    
    override func awakeFromNib() {
        self.contentView.layer.cornerRadius = 5
    }
    
    
    func configureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        
        nameLbl.text = pokemon.name.capitalized
        thumbImg.image = UIImage(named:"\(pokemon.pokedexid)")
        
    }
}
