//
//  SaveProductVM.swift
//  MyApi
//
//  Created by Macbook Air on 5.04.2023.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore


protocol AddProductDelegate : AnyObject {
    
  
    
}

class AddProductVM {
    
    let db = DB.shared.firebase
    let storage = ImageStorage.shared.storage

    
    var categories = ["Genç Odaları","Bebek Odaları","Yatak Odaları"]
    
    var selectedIndex : Int = 0
    
    weak var delegate : AddProductDelegate?
    
    func numberOfRows() -> Int {
        return categories.count
    }
    
    func titleForRow(row index : Int) -> String {
        return categories[index]
    
    }
    
    func didSelectRow(selectedRow index : Int){
        self.selectedIndex = index
    }
    
    func saveProduct(name : String , price : String ,categories : String,pieceDetails : [ProductPieces], imageData : Data , completionHandler : @escaping (String?,Error?) -> Void){
        
        let ref  = storage.child("Products").child(categories).child(name)
        
        ref.putData(imageData) { _, error in
            if error != nil {
                completionHandler(nil,error)
            }else {
                ref.downloadURL { [self]  url, err in
                    if err != nil {
                        print(err!.localizedDescription)
                    }else {
                        let id = UUID().uuidString
                        db.collection("Products").document(categories).collection("mainScreenImages").document(name).setData(["id" : id,"name" : name,"price" : price,"categories" : categories ,"image_url" : url?.absoluteString ?? "Unknown url"])
                        
                        pieceDetails.forEach { pieces in
                            
                            let tempId = UUID().uuidString
                            ref.child(tempId).putData(pieces.images) { _, err in
                                if err != nil {
                                    print(err!.localizedDescription)
                                }else {
                                    ref.child(tempId).downloadURL { url, err in
                                        if url != nil , error == nil {
                                            var url = url?.absoluteString
                                            self.db.collection("Products").document(categories).collection("products").document(id).collection("parcalar").document(pieces.name).setData(["aciklama" : pieces.description , "ad" : pieces.name , "fiyat" : pieces.price , "olcu" : pieces.sizes , "resim" : url!])
                                        }
                                       
                                        
                                    }
                                }
                                
                            }

                        }
                    
                        completionHandler("Ürün başarıyla veritabanına yüklendi",nil)
                        
                    }
                }
            }
        
        }
    }
    
    
   
    
    
}
