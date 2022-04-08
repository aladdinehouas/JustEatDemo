//
//  HomeLocalDataManager.swift
//  JustEatDemo
//
//  Created by Alaeddine Houas on 30/3/2022.
//

import Foundation
enum DataError: Error {
    case badURL
}

class HomeLocalDataManager: HomeLocalDataManagerProtocol{
    
    func retrieveRestaurants() -> Result<[Restaurant], DataError> {
        let decoder = JSONDecoder()
        guard
             let data = loadData(fileName: "example"),
             let restaurants = try? decoder.decode([Restaurant].self, from: data, keyPath: "restaurants")
        else {
            return .failure(.badURL)
        }
        return .success(restaurants)
    }
    
    private func loadData(fileName: String) -> Data? {
       guard
            let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url)
       else {
            return nil
       }

       return data
    }
    
}
