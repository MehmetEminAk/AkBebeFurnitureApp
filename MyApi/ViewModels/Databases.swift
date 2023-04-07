//
//  Databases.swift
//  MyApi
//
//  Created by Macbook Air on 5.04.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class DB {
    
    public static let shared = DB()
    
    public let firebase = Firestore.firestore()
    
    private init(){}
    
}

class ImageStorage {
    
    public static let shared = ImageStorage()
    
    public let storage = Storage.storage().reference()
    
    private init(){}
}
