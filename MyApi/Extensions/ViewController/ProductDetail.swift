//
//  ProductDetail.swift
//  MyApi
//
//  Created by Macbook Air on 6.04.2023.
//

import Foundation
import UIKit
import Kingfisher

extension ProductDetailVC {
    
    
    
    @objc
    func changeTheObjects(){
        productImages.kf.setImage(with: URL(string: viewModel.imagesUrlStrings[pageControl.currentPage]))
        productDetailLabel.attributedText = viewModel.details[pageControl.currentPage]
        
    }
    
    
    
    func initialConfig(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeTheObjects), name: NSNotification.Name("ChangeImage"), object: nil)
        
        DispatchQueue.main.async {
            
            self.pageControl.numberOfPages = self.viewModel.imagesUrlStrings.count
            
            self.productImages.kf.setImage(with: URL(string: self.viewModel.imagesUrlStrings[0]))
            self.productDetailLabel.attributedText = self.viewModel.details[0]
        }
        
        
        
    }
    
    func addGestures(){
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(changeThePage(_:)))
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(changeThePage(_:)))
        
        leftSwipeGesture.delegate = self
        rightSwipeGesture.delegate = self
        
        
        leftSwipeGesture.direction = .left
        
        productImages.addGestureRecognizer(rightSwipeGesture)
        
        productImages.addGestureRecognizer(leftSwipeGesture)
        
        
        
        
    }
    
    
    func updateUI() {
        initialConfig()
    }
    
    @objc
    func decreaseSecond(){
        second -= 1
        secondsLabel.text = "\(second)"
    }
    
    @objc
    func changeThePage(_ sender : UISwipeGestureRecognizer){
        
        
        switch sender.direction {
        case .left :

            if pageControl.currentPage < pageControl.numberOfPages  {
                pageControl.currentPage += 1
                NotificationCenter.default.post(name: NSNotification.Name("ChangeImage"), object: nil)
                
                
            }
            
        case .right :
            

            
            if pageControl.currentPage != 0 {
                pageControl.currentPage -= 1
                NotificationCenter.default.post(name: NSNotification.Name("ChangeImage"), object: nil)
            }
            
        default :
            print("Unknown error")
        }
    }
    
    
}
