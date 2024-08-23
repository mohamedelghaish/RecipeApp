//
//  RecipeViewModel.swift
//  RecipeApp
//
//  Created by Mohamed Kotb Saied Kotb on 23/08/2024.
//

import Foundation

class RecipeViewModel {
    private let recipe: Recipe
    
    init(recipe: Recipe) {
        self.recipe = recipe
    }
    
    var title: String {
        return recipe.label
    }
    
    var imageURL: URL? {
        return URL(string: recipe.image)
    }
    
    var source: String {
        return recipe.source
    }
    
    var totalTime: String {
        return "\(recipe.totalTime) minutes"
    }
    
    var calories: String {
        return String(format: "%.2f", recipe.calories)
    }
    
    var totalWeight: String {
        return String(format: "%.2f", recipe.totalWeight)
    }
}
