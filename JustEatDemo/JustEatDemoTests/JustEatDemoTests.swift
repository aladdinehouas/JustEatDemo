//
//  JustEatDemoTests.swift
//  JustEatDemoTests
//
//  Created by Alaeddine Houas on 8/4/2022.
//

import XCTest
@testable import JustEatDemo

class JustEatDemoTests: XCTestCase {

    class MockHomeInteractor: HomeInteractorProtocol{
        var presenter: HomePresenterProtocol?
        var localDatamanager: HomeLocalDataManagerProtocol?
        let fakeRestaurants = [
            Restaurant(withName: "restaurant#1", status: .open, sortingValues: SortingValues(bestMatch: 0, newest: 96, ratingAverage: 4, distance: 1190, popularity: 17, averageProductPrice: 1536, deliveryCosts: 200, minCost: 1000)),
            Restaurant(withName: "restaurant#2", status: .closed, sortingValues: SortingValues(bestMatch: 0, newest: 96, ratingAverage: 3.5, distance: 1000, popularity: 17, averageProductPrice: 1536, deliveryCosts: 0, minCost: 500)),
            Restaurant(withName: "restaurant#3", status: .orderAhead, sortingValues: SortingValues(bestMatch: 0, newest: 96, ratingAverage: 5, distance: 600, popularity: 17, averageProductPrice: 1536, deliveryCosts: 100, minCost: 700))
        ]
        
        func retrieveRestaurants() {
            presenter?.didRetrieveRestaurants(fakeRestaurants)
        }
    }
    
    let presenter: HomePresenterProtocol = HomePresenter()
    let interactor: HomeInteractorProtocol = MockHomeInteractor()
    
    override func setUp() {
        super.setUp()
        presenter.interactor = interactor
        interactor.presenter = presenter
    }
    
    override func tearDown() {
        super.tearDown()
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testRestaurantsCount(){
        presenter.viewDidLoad()
        XCTAssertEqual(presenter.numberOfItems, 3)
    }
    
    func testItemAtIndex(){
        presenter.viewDidLoad()
        let item = presenter.item(at: 2)
        XCTAssertEqual(item.name, "restaurant#3")
    }

    func testOpenStateSortOption(){
        presenter.viewDidLoad()
        presenter.sortRestaurants(by: .openState)
        XCTAssertEqual(presenter.item(at: 0).name, "restaurant#1")
        XCTAssertEqual(presenter.item(at: 1).name, "restaurant#3")
        XCTAssertEqual(presenter.item(at: 2).name, "restaurant#2")
    }

    func testDistanceSortOption(){
        presenter.viewDidLoad()
        presenter.sortRestaurants(by: .distance)
        XCTAssertEqual(presenter.item(at: 0).name, "restaurant#3")
        XCTAssertEqual(presenter.item(at: 1).name, "restaurant#2")
        XCTAssertEqual(presenter.item(at: 2).name, "restaurant#1")
    }
}
