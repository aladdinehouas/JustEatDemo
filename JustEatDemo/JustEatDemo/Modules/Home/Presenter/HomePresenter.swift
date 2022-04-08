//
//  HomePresenter.swift
//  JustEatDemo
//
//  Created by Alaeddine Houas on 30/3/2022.
//

import Foundation

class HomePresenter{
    
    // MARK: - Internal properties -
    var view: HomeViewProtocol?
    var interactor: HomeInteractorProtocol?
    var wireFrame: HomeWireFrameProtocol?
    
    // MARK: - Private properties -
    
    private var items = [Restaurant](){
        didSet {
            itemsToShow = items
        }
    }
    
    private var itemsToShow = [Restaurant](){
        didSet {
            view?.reloadData()
        }
    }
    
}

// MARK: - Extensions -

extension HomePresenter: HomePresenterProtocol{
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retrieveRestaurants()
    }
    
    var numberOfItems: Int {
        itemsToShow.count
    }
    
    func item(at index: Int) -> Restaurant {
        itemsToShow[index]
    }
    
    func showSortView() {
        wireFrame?.presentSortScreen(from: view!)
    }
    
    func getAllItems() {
        if let option = UserDefaults.sortOptionKey{
            sortRestaurants(by: option)
        } else {
            itemsToShow = items
        }
    }
    
    func sortRestaurants(by sortOption: SortOption) {
        switch sortOption {
        case .alphabet:
            itemsToShow = items.sorted { $0.name ?? "" < $1.name ?? "" }
        case .openState:
            itemsToShow = items.sorted { $0.status ?? .closed < $1.status ?? .closed }
        case .ratingAverage:
            itemsToShow = items.sorted { $0.sortingValues?.ratingAverage ?? 0 > $1.sortingValues?.ratingAverage ?? 0 }
        case .distance:
            itemsToShow = items.sorted { $0.sortingValues?.distance ?? 0 < $1.sortingValues?.distance ?? 0 }
        case .minCost:
            itemsToShow = items.sorted { $0.sortingValues?.minCost ?? 0 < $1.sortingValues?.minCost ?? 0 }
        case .deliveryCosts:
            itemsToShow = items.sorted { $0.sortingValues?.deliveryCosts ?? 0 < $1.sortingValues?.deliveryCosts ?? 0 }
        }
    }
    
    func filterRestaurants(with text: String) {
        itemsToShow = items.filter {
            $0.name?.lowercased().contains(text.lowercased()) ?? false
        }
        
    }
    
    func didRetrieveRestaurants(_ restaurants: [Restaurant]) {
        view?.hideLoading()
        self.items = restaurants
        if let option = UserDefaults.sortOptionKey{
            sortRestaurants(by: option)
        }
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
}
