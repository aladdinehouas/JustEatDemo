//
//  SortingWireFrame.swift
//  JustEatDemo
//
//  Created by Alaeddine Houas on 3/4/2022.
//

import UIKit

class SortingWireFrame: SortingWireFrameProtocol {
    
    static func createSortingModule() -> UIViewController{
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "SortViewController")
        if let view = viewController as? SortViewController {
            let presenter: SortingPresenterProtocol = SortingPresenter()
            let wireFrame: SortingWireFrameProtocol = SortingWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
