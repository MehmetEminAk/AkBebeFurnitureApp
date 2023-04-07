//
//  ShowProductsVM.swift
//  MyApi
//
//  Created by Macbook Air on 5.04.2023.
//

import Foundation
import UIKit
import Kingfisher


protocol ShowProductDelegate : AnyObject {
    func updateUI()
}

class ShowProductVM {
    
    
    
    weak var delegate : ShowProductDelegate?
    
    var products : [Product] = []
    var filteredProducts : [Product] = []
    
    private var db =  DB.shared.firebase
    
    
    
    
    func fetchProducts(category : ProductCategory) {
        
        self.filteredProducts.removeAll()
        self.products.removeAll()
        
        
        
        
        db.collection("Products").document(category.rawValue).collection("mainScreenImages").getDocuments { snapshot, error in
            
            
            
            if error != nil {
                print(error!.localizedDescription)
            }else {
                snapshot!.documents.forEach { doc in
                    
                    
                    let name = doc.data()["name"] as! String
                    let price = doc.data()["price"] as! String
                    let category = doc.data()["categories"] as! String
                    let image   = doc.data()["image_url"] as! String
                        let id   = doc.data()["id"] as! String
                    
                    
                    self.products.append(Product(id: id,name: name,category: category,price: price, imageString: image))
                    
                    self.filteredProducts.append(Product(id : id,name: name,category: category,price: price, imageString: image))
                     
                    
                }
                self.delegate?.updateUI()
                
            }
        }
    }
    
    
    func numberOfSections() -> Int {
        return filteredProducts.count
    }
    
    func categoryChanged(selectedCategory : Int){
        
        switch selectedCategory {
        case 0 :
            fetchProducts(category: .babyroomfurnitures)
        
        case 1 :
            fetchProducts(category: .teenagerroomfurniture)
            
        case 2 :
            fetchProducts(category: .bedroomfurniture)
            
            
        default:
            print("Unknown category")
        }
    }
    
    
    func cellForItem(collectionView : UICollectionView , indexPath : IndexPath ) -> UICollectionViewCell {
        
     
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCVC
        
        item.layer.cornerRadius = 15
        
        
        var currentProduct = filteredProducts[indexPath.row]
         
        item.setup(with: currentProduct)
        
        return item
        
        
    }
    
    func searchProduct(searchedText : String?){
        if let searchedText = searchedText, searchedText.count > 2 {
            filteredProducts =  filteredProducts.filter { pro in
                return pro.name.contains(searchedText)
                
            }
            
            delegate?.updateUI()
        }else {
            filteredProducts = products
            delegate?.updateUI()
        }
    }
    
    
}

enum ProductCategory : String {
    case babyroomfurnitures = "Bebek Odaları"
    case teenagerroomfurniture = "Genç Odaları"
    case bedroomfurniture = "Yatak Odaları"
    
}
