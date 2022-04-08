//
//  HomeInteractorProtocol.swift
//  JustEatDemo
//
//  Created by Alaeddine Houas on 30/3/2022.
//

import Foundation

class HomeInteractor: HomeInteractorProtocol{
    var presenter: HomePresenterProtocol?
    var localDatamanager: HomeLocalDataManagerProtocol?
    
    func retrieveRestaurants() {
        if let result = localDatamanager?.retrieveRestaurants() {
            switch result{
            case .success(let restaurants):
                presenter?.didRetrieveRestaurants(restaurants)
            case .failure(_):
                presenter?.onError()
            }
            
        } else {
            presenter?.onError()
        }
    }
}
