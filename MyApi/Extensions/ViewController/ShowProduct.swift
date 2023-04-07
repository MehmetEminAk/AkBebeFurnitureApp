//
//  ShowProduct.swift
//  MyApi
//
//  Created by Macbook Air on 6.04.2023.
//

import Foundation
import UIKit



extension ShowProductVC : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchProduct(searchedText : searchText)

    }
    
}

extension ShowProductVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    func configureCollectionView(){
        
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        productsList.collectionViewLayout = flowLayout
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        viewModel.cellForItem(collectionView: collectionView, indexPath: indexPath)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.filteredProducts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: deviceWidth * 0.45, height: deviceHeight * 0.3)
    }
    
    func updateUI() {
        
        DispatchQueue.main.async {
            
            self.productsList.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "toProductDetail", sender: indexPath.row)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProductDetail" {
            
            let selectedProduct = viewModel.filteredProducts[sender as! Int]
            
            let destVC = segue.destination as! ProductDetailVC
            
            destVC.productId = selectedProduct.id
            destVC.productCategory = selectedProduct.category
        }
    }
    
    
}
