//
//  SaveProduct.swift
//  MyApi
//
//  Created by Macbook Air on 5.04.2023.
//

import Foundation
import UIKit

extension SaveProductVC : UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    
    func configurePicker(picker : UIImagePickerController){
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.modalPresentationStyle = .fullScreen
    }
    
    @objc
    func imageClicked(){
        configurePicker(picker: picker)
        self.present(picker, animated: true)
    }
    
    @objc
    func pieceImageClicked(){
        configurePicker(picker: secondPicker)
        self.present(secondPicker, animated: true)
    }
    
    @objc
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func controlPageValueChanged(){
        pieceNameTF.text = ""
        piecePriceTF.text = ""
        pieceSizesTF.text = ""
        pieceDescriptionTF.text = ""
        choosePieceImage.image = UIImage(systemName: "photo")?.withTintColor(.opaqueSeparator)
        currentPieceHeader.text = "\(numberOfPiecesPageControl.currentPage + 1).Parça ile alakalı bilgileri yazınız"
        currentPieceSaveBtn.setTitle("\(numberOfPiecesPageControl.currentPage + 1). Parçayı Kaydet", for: .normal)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if picker == self.picker {
            
            chooseImage.image = info[.editedImage] as? UIImage
            picker.dismiss(animated: true)
            
        }else if picker == self.secondPicker {
            
            choosePieceImage.image = info[.originalImage] as? UIImage
            picker.dismiss(animated: true)
        }
    }
    
    
}

extension SaveProductVC :  UIPickerViewDelegate , UIPickerViewDataSource {
    
   
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         viewModel.numberOfRows()
     }
     
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         viewModel.titleForRow(row: row)
     }
     
     
     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         viewModel.didSelectRow(selectedRow: row)
         
     }
     
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }
}

extension SaveProductVC : AddProductDelegate {
    
   
    
    func addGestures(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(imageClicked))
        chooseImage.addGestureRecognizer(gesture)
        
        let dissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(dissGesture)
        
        let pieceGestue = UITapGestureRecognizer(target: self, action: #selector(pieceImageClicked))
        choosePieceImage.addGestureRecognizer(pieceGestue)
        
    }
}
