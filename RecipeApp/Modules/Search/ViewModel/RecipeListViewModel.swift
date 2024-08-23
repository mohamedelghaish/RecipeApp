//
//  RecipeListViewModel.swift
//  RecipeApp
//
//  Created by Mohamed Kotb Saied Kotb on 23/08/2024.
//
//

class RecipeListViewModel {
    var recipes: [Recipe] = []
    var currentPage = 0
    var currentQuery = ""
    var selectedHealthFilter: String? = nil
    
    var reloadTableView: (() -> Void)?
    var url: String = ""
    
    func searchRecipes(query: String, pageNumber: Int, reset: Bool = false) {
        if reset {
            url = NetworkManager.shared.createURL(query: query, health: selectedHealthFilter)
            currentPage = 0
            recipes.removeAll()
        } else {
            currentPage = pageNumber
        }
       
        NetworkManager.shared.fetchRecipes(url: url) { [weak self] result in
            switch result {
            case .success(let recipeResponse):
                let newRecipes = recipeResponse.hits.map { $0.recipe }
                let nextPageURL = recipeResponse.links.next?.href
                self?.url = nextPageURL ?? ""
                
                if reset {
                    self?.recipes = newRecipes
                } else {
                    self?.recipes.append(contentsOf: newRecipes)
                }
                
                self?.reloadTableView?()
                
            case .failure(let error):
                print("Error fetching recipes: \(error)")
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

