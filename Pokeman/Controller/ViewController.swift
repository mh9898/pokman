//
//  ViewController.swift
//  Pokeman
//
//  Created by Michael Harari on 07/05/2020.
//  Copyright © 2020 mh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collection: UICollectionView!
    
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let chraminend = Pokemon(name: "chraminend", pokedexid: 4)
 
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self

        prasePokemonCSV()
        
        
    }

    func prasePokemonCSV(){
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")!
        
        do{
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            print(rows)
            
            for row in rows{
                let pokeid = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexid: pokeid)
                pokemons.append(poke)
            }
            
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }

}

extension ViewController: UICollectionViewDelegate{
    
}


extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode{
            return filteredPokemons.count
        }
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            
//            let pokemon = Pokemon(name: "PokeMom", pokedexid: indexPath.row + 1)
//            let pokemon = pokemons[indexPath.row]
//            cell.configureCell(pokemon: pokemon)
            
            if inSearchMode{
                let filterdpokemon = filteredPokemons[indexPath.row]
                cell.configureCell(pokemon: filterdpokemon)
            }
            else{
                let pokemon = pokemons[indexPath.row]
                cell.configureCell(pokemon: pokemon)
            }
            
            return cell
        } else{
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == ""{
            inSearchMode = false
            collection.reloadData()
            view.endEditing(true)
        }
        else{
            inSearchMode = true
            let lower = searchBar.text!.lowercased()
            filteredPokemons = pokemons.filter({$0.name.range(of: lower) != nil})
            collection.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

