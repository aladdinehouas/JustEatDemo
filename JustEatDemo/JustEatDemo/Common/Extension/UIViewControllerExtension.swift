//
//  UIViewControllerExtension.swift
//  JustEatDemo
//
//  Created by Alaeddine Houas on 7/4/2022.
//

import UIKit
import MBProgressHUD

extension UIViewController {
    
    //MARK: ProgressHUD
    
    // User this method directly from the UIViewController to show UIActivityIndicater and to block the screen
    func showHud() {
        self.hideHUD()
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.mode = MBProgressHUDMode.indeterminate
        hud.backgroundView.style = .solidColor
        hud.show(animated: true)
    }
    
    // User this method directly from the UIViewController to hide UIActivityIndicater
    func hideHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    //MARK: Alerts
    
    
    func showAlert(withTitle title: String?, message: String? ) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
     Use this method directly from the UIViewController to show Error Alert
     */
    
    func showFailureAlert(){
        let alertController = UIAlertController(title: nil,
                                                message: "Oops! Something went wrong.",
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
