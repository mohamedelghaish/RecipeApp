//
//  Recipe.swift
//  RecipeApp
//
//  Created by Mohamed Kotb Saied Kotb on 23/08/2024.
//

import Foundation
struct Recipe: Codable {
    let label: String
    let image: String
    let source: String
    let totalTime: Int
    let calories: Double
    let totalWeight: Double
}

struct RecipeResponse: Codable {
    let hits: [RecipeHit]
    let links: RecipeLinks
        
        enum CodingKeys: String, CodingKey {
            case hits
            case links = "_links"
        }
}

struct RecipeLink: Codable {
    let href: String
    let title: String
}
struct RecipeLinks: Codable {
    let next: RecipeLink?
}
struct RecipeHit: Codable {
    let recipe: Recipe
}
