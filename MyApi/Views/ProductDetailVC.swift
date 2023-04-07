//
//  ProductDetailVC.swift
//  MyApi
//
//  Created by Macbook Air on 6.04.2023.
//

import UIKit

class ProductDetailVC: UIViewController , UIGestureRecognizerDelegate , ProductDetailDelegate  {

    
    var productId : String!
    var productCategory : String!
    var productName : String!
    var second  = 56
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var productImages: UIImageView!
    
    
    @IBOutlet weak var productDetailLabel: UILabel!
    
    @IBOutlet weak var secondsLabel: UILabel!
    

    var viewModel = ProductDetailVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGestures()
        viewModel.delegate = self
        viewModel.fetchProductWithId(id: productId, productCategory: productCategory)
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseSecond), userInfo: nil, repeats: true)
        
        
    }
    
    @IBAction func contactFromWpClicked(_ sender: Any) {
            
        let message = "Merhaba , ürünler hakkında bilgi almak istiyorum."
        
            let phoneNumber = "+905303452144"
            let url = "whatsapp://send?phone=\(phoneNumber)&text=\(message)"

            if let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL) {
                    UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                } else {
                    // WhatsApp is not installed on the device
                }
            }
            
        
    }
    
    
    
}
