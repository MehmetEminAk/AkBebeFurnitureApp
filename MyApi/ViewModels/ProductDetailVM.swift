//
//  ProductDetailVM.swift
//  MyApi
//
//  Created by Macbook Air on 6.04.2023.
//

import Foundation
import UIKit


protocol ProductDetailDelegate : AnyObject {
    
    func updateUI()
    
}

class ProductDetailVM {
    
    var details : [NSMutableAttributedString] = []
    var imagesUrlStrings : [String] = []
    
    let db = DB.shared.firebase
    weak var delegate : ProductDetailDelegate?
    
    func fetchProductWithId(id : String , productCategory : String){
        
        
        
        db.collection("Products").document(productCategory).collection("products").document(id).collection("parcalar").getDocuments { snapshot, error in
            if  (snapshot?.documents.count)! > 0 , error == nil {
                
                snapshot?.documents.forEach({ doc in
                    
                    
                    
                    var description = doc.data()["aciklama"] as! String
                    var name = doc.data()["ad"] as! String
                    var price = "\n ŞOK KAMPANYA!! 🎉🎉 Sadece " +  (doc.data()["fiyat"] as! String) + "\n\n"
                    var sizes = "\n\n Ölçüler : " + (doc.data()["olcu"] as! String) + "\n"
                    var image = doc.data()["resim"] as! String
                    
                    var attrString = NSMutableAttributedString(string: name,attributes: [.foregroundColor : UIColor.systemGray , .font : UIFont.systemFont(ofSize: 24, weight: .bold)])
                    
                    
                    attrString.append(NSAttributedString(string: sizes))
                    attrString.append(NSMutableAttributedString(string: price, attributes: [.foregroundColor : UIColor.systemOrange , .font : UIFont.systemFont(ofSize: 22, weight: .bold)]))
                    attrString.append(NSAttributedString(string: description))

                    
                    self.details.append(attrString)
                    self.imagesUrlStrings.append(image)
                    
                    
                    
                })
                self.delegate?.updateUI()
                
            } else {
                print(error!.localizedDescription)
            }
            
            
        }
    }
    
    
}
