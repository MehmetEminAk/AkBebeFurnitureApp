//
//  General.swift
//  MyApi
//
//  Created by Macbook Air on 5.04.2023.
//

import Foundation
import UIKit


extension UIView {
    func addSubviews(_ views : [UIView]){
        views.forEach { view in
            self.addSubview(view)
        }
    }
}

extension UIViewController {
    func generateAlert(title : String, message : String,actions : [UIAlertAction] = [] ,style : UIAlertController.Style = .alert) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        actions.forEach { action in
            alert.addAction(action)
        }
        
        return alert
        
    }
}
