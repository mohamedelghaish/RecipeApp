//
//  NetworkManager.swift
//  RecipeApp
//
//  Created by Mohamed Kotb Saied Kotb on 23/08/2024.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.edamam.com/api/recipes/v2"
    private let appID = "56657b2d"
    private let appKey = "cbbb92916df19521a3b4d1e403e7130c"
    
    func fetchRecipes(query: String, health: String?, page: Int = 0, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        var parameters: [String: String] = [
            "type": "public",
            "q": query,
            "app_id": appID,
            "app_key": appKey
        ]
        
        if let healthFilter = health {
            parameters["health"] = healthFilter
        }
        
        let url = baseURL
        AF.request(url, parameters: parameters).responseDecodable(of: RecipeResponse.self) { response in
            switch response.result {
            case .success(let recipeResponse):
                let recipes = recipeResponse.hits.map { $0.recipe }
                completion(.success(recipes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
