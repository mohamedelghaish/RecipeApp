//
//  RecipeListViewModel.swift
//  RecipeApp
//
//  Created by Mohamed Kotb Saied Kotb on 23/08/2024.
//

import Foundation

class RecipeListViewModel {
    var recipes: [Recipe] = []
    var currentPage = 0
    var currentQuery = ""
    var selectedHealthFilter: String? = nil
    
    var reloadTableView: (() -> Void)?
    
    func searchRecipes(query: String, reset: Bool = false) {
        if reset {
            currentPage = 0
            recipes.removeAll()
        }
        
        NetworkManager.shared.fetchRecipes(query: query, health: selectedHealthFilter, page: currentPage) { [weak self] result in
            switch result {
            case .success(let newRecipes):
                self?.recipes.append(contentsOf: newRecipes)
                self?.reloadTableView?()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getRecipe(at index: Int) -> RecipeViewModel {
        let recipe = recipes[index]
        return RecipeViewModel(recipe: recipe)
    }
    
    func numberOfRecipes() -> Int {
        return recipes.count
    }
}
