//
//  ShowProductVC.swift
//  MyApi
//
//  Created by Macbook Air on 5.04.2023.
//

import UIKit

class ShowProductVC: UIViewController , ShowProductDelegate  {
   
    
    
    var viewModel = ShowProductVM()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    @IBOutlet weak var productsList: UICollectionView!
    
    
    @IBOutlet weak var categorySegmentedControl: UISegmentedControl!
    
    
    @IBAction func categoryChanged(_ sender: Any) {
        viewModel.categoryChanged(selectedCategory: categorySegmentedControl.selectedSegmentIndex)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureCollectionView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        viewModel.categoryChanged(selectedCategory: categorySegmentedControl.selectedSegmentIndex)
        
    }
    
}
