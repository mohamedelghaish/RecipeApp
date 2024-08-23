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
//    
//    func fetchRecipes(query: String, health: String?, page: Int = 0, completion: @escaping (Result<[Recipe], Error>) -> Void) {
//        var parameters: [String: String] = [
//            "type": "public",
//            "q": query,
//            "app_id": appID,
//            "app_key": appKey
//        ]
//        
//        if let healthFilter = health {
//            parameters["health"] = healthFilter
//        }
//        
//        let url = baseURL
//        AF.request(url, parameters: parameters).responseDecodable(of: RecipeResponse.self) { response in
//            switch response.result {
//            case .success(let recipeResponse):
//                let recipes = recipeResponse.hits.map { $0.recipe }
//                completion(.success(recipes))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//    
    
    
    func createURL(query: String, health: String?, page: Int = 0) -> String {
        var components = URLComponents(string: baseURL)
        components?.queryItems = [
            URLQueryItem(name: "type", value: "public"),
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "app_id", value: appID),
            URLQueryItem(name: "app_key", value: appKey)
        ]
        
        if let healthFilter = health {
            components?.queryItems?.append(URLQueryItem(name: "health", value: healthFilter))
        }
        
        // Return the URL as a string, or an empty string if the URL is nil
        return components?.url?.absoluteString ?? ""
    }


    func fetchRecipes(url:String, completion: @escaping (Result<RecipeResponse, Error>) -> Void) {
        
        AF.request(url).responseDecodable(of: RecipeResponse.self) { response in
                switch response.result {
                case .success(let recipeResponse):
                    // Return the entire response
                    completion(.success(recipeResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            
        }
    }
}
