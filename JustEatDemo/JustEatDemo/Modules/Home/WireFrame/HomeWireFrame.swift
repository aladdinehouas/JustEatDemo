//
//  HomeWireFrame.swift
//  JustEatDemo
//
//  Created by Alaeddine Houas on 30/3/2022.
//

import UIKit

class HomeWireFrame: HomeWireFrameProtocol{
    
  
    static func createHomeModule() -> UIViewController {
        
        if let view = mainStoryboard.instantiateViewController(withIdentifier: String(describing: HomeViewController.self)) as? HomeViewController {
            let navigationController = UINavigationController.init(rootViewController: view)
            let presenter: HomePresenterProtocol = HomePresenter()
            let interactor: HomeInteractorProtocol = HomeInteractor()
            let localDataManager: HomeLocalDataManagerProtocol = HomeLocalDataManager()
            let wireFrame: HomeWireFrameProtocol = HomeWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            
            return navigationController
        }
        return UIViewController()
    }
    
    func presentSortScreen(from view: HomeViewProtocol) {
        
        let sortingView = SortingWireFrame.createSortingModule()
   
        if let sourceView = view as? UIViewController, let sortViewController = sortingView as? SortViewController  {
            sortViewController.modalPresentationStyle = .overCurrentContext
            sortViewController.delegate = view
            sourceView.present(sortViewController, animated: true, completion: nil)
        }
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
   
}
