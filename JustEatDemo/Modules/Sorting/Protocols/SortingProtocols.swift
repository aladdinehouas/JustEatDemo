//
//  SortingProtocols.swift
//  JustEatDemo
//
//  Created by Alaeddine Houas on 3/4/2022.
//

import Foundation

import UIKit

protocol SortingViewProtocol: AnyObject {
    var presenter: SortingPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func select(sortOption option: SortOption)
}

protocol SortingWireFrameProtocol: AnyObject {
    static func createSortingModule() -> UIViewController
}

protocol SortingPresenterProtocol: AnyObject {
    var view: SortingViewProtocol? { get set }
    var wireFrame: SortingWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func didSelect(option: SortOption?)
}
