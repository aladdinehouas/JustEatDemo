//
//  SortingPresenter.swift
//  JustEatDemo
//
//  Created by Alaeddine Houas on 7/4/2022.
//

import Foundation

class SortingPresenter: SortingPresenterProtocol{
    
    var view: SortingViewProtocol?
    var wireFrame: SortingWireFrameProtocol?
    
    func viewDidLoad() {
        if let selectedOption = UserDefaults.sortOptionKey{
            view?.select(sortOption: selectedOption)
        }
    }
    
    func didSelect(option: SortOption?) {
        if let option = option {
            UserDefaults.sortOptionKey = option
        }
    }
}
