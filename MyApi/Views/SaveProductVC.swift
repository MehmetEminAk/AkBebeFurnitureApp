//
//  ViewController.swift
//  MyApi
//
//  Created by Macbook Air on 2.04.2023.
//

import UIKit
import JGProgressHUD

class SaveProductVC: UIViewController {
    
    
    var viewModel = AddProductVM()
    
    
    let picker = UIImagePickerController()
    let secondPicker = UIImagePickerController()
    
    
    @IBOutlet weak var piecesDetailsView: UIView!
    @IBOutlet weak var numberOfPiecesTF : UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    
    
    
    @IBOutlet weak var pieceNameTF: UITextField!
    
    @IBOutlet weak var piecePriceTF: UITextField!
    
    @IBOutlet weak var pieceSizesTF: UITextField!
    
    @IBOutlet weak var pieceDescriptionTF: UITextView!
    
    @IBOutlet weak var choosePieceImage: UIImageView!
    
    
    var hud : JGProgressHUD = {
        let hud =   JGProgressHUD(style: .light)
        hud.frame = CGRect(x: deviceWidth / 2 - 100, y: deviceHeight / 2 - 100, width: 200, height: 200)
        hud.textLabel.text = "Ürün yükleniyor..."
        return hud
    }()
    
    
    @IBAction func currentPieceSaveButton(_ sender: Any) {
        
        let pieceImageData = choosePieceImage.image?.jpegData(compressionQuality: 0.5)

        
        pieces.append(ProductPieces(name: pieceNameTF.text!, description: pieceDescriptionTF.text!, price: piecePriceTF.text!, sizes: pieceSizesTF.text!, images: pieceImageData!))
        
        let alert = self.generateAlert(title: "Başarılı", message: "Parça başarıyla eklendi", actions: [UIAlertAction(title: "TAMAM", style: .cancel, handler: {  _ in
            self.numberOfPiecesPageControl.currentPage += 1
            
            self.controlPageValueChanged()
        })])
        self.present(alert, animated: true)
        
    }
    
    @IBOutlet weak var currentPieceHeader: UILabel!
    
    
    @IBOutlet weak var chooseImage: UIImageView!
    
    var pieces : [ProductPieces] = []
    
    @IBOutlet weak var numberOfPiecesPageControl: UIPageControl!
    
    
    @IBOutlet weak var currentPieceSaveBtn: UIButton!
    
 

  
    @IBOutlet weak var categoriesPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addGestures()
        chooseImage.layer.cornerRadius = 15
        piecesDetailsView.isHidden = true
        
        
    }
    
   
    
    @IBAction func PieceChanged(_ sender: Any) {
        
        if let piecesNumber = numberOfPiecesTF.text ,  piecesNumber.count >= 1 {
            numberOfPiecesTF.text = "\(piecesNumber.first!)"
            
            piecesDetailsView.isHidden = false
            
           
            numberOfPiecesPageControl.numberOfPages = Int("\(piecesNumber.first!)")!
            
            
            numberOfPiecesPageControl.currentPage = 0

            
            
            
            
        }
        
        
    }
    
    @IBAction func piecePageControlChanged(_ sender: Any) {
        
        controlPageValueChanged()
        
    }
    
    
    
    
    @IBAction func saveProductClicked(_ sender: Any) {
        
        hud.show(in: view)
      
        let selectedCategory = viewModel.categories[viewModel.selectedIndex]
        
        let imageData = chooseImage.image?.jpegData(compressionQuality: 0.5)
        
        let name = nameTF.text!
        let price = priceTF.text!
        
    
        viewModel.saveProduct(name: name, price: price, categories: selectedCategory,pieceDetails: pieces ,  imageData: imageData!) { message, error in
            
            if error != nil {
                let alert = self.generateAlert(title: "HATA!", message: error!.localizedDescription , actions: [UIAlertAction(title: "TAMAM", style: .cancel)])
                self.hud.dismiss(animated: true)

                self.present(alert, animated: true)
            }else {
                let alert = self.generateAlert(title: "ÜRÜN EKLENDİ!", message: message! ,actions: [UIAlertAction(title: "TAMAM", style: .cancel,handler: { _ in
                    self.tabBarController?.selectedIndex = 0
                })])
                self.hud.dismiss(animated: true)
                self.present(alert, animated: true)
            }
        }
        
       
    }
}


