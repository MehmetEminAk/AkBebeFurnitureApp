//
//  ProductCVC.swift
//  MyApi
//
//  Created by Macbook Air on 5.04.2023.
//

import UIKit

class ProductCVC: UICollectionViewCell {


    
    @IBOutlet weak var productImage: UIImageView!
    
    
    @IBOutlet weak var productName: UILabel!

    @IBOutlet weak var productPrice : UILabel!

    
    
    func setup(with product : Product){
        
        productImage.kf.setImage(with: URL(string: product.imageString))

        productName.text = product.name
        productPrice.text = "\(product.price) ₺"
    }

}
