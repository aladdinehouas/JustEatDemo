//
//  HomeProtocols.swift
//  JustEatDemo
//
//  Created by Alaeddine Houas on 29/3/2022.
//

import UIKit

protocol HomeViewProtocol: SortViewDelegate {
    var presenter: HomePresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func reloadData()
    func showError()
    func showLoading()
    func hideLoading()
}

protocol HomeWireFrameProtocol: AnyObject {
    static func createHomeModule() -> UIViewController
    // PRESENTER -> WIREFRAME
    func presentSortScreen(from view: HomeViewProtocol)
}

protocol HomePresenterProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var wireFrame: HomeWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    var numberOfItems: Int { get }
    func item(at index: Int) -> Restaurant
    func getAllItems()
    func showSortView()
    func sortRestaurants(by sortOption: SortOption)
    func filterRestaurants(with text: String)
    
    // INTERACTOR -> PRESENTER
    func didRetrieveRestaurants(_ restaurants: [Restaurant])
    func onError()
}

protocol HomeInteractorProtocol: AnyObject {
    var presenter: HomePresenterProtocol? { get set }
    var localDatamanager: HomeLocalDataManagerProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveRestaurants()
}

protocol HomeLocalDataManagerProtocol: AnyObject {
     // INTERACTOR -> LOCALDATAMANAGER
    func retrieveRestaurants() -> Result<[Restaurant], DataError>
}
