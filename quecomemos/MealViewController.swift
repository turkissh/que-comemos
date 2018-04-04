//
//  MealViewController.swift
//  quecomemos
//
//  Created by Emiliano Di Pierro on 10/13/16.
//  Copyright © 2016 Emiliano Di Pierro. All rights reserved.
//

import UIKit


protocol MealTableViewControllerDelegate {
    func updateMeal(meal: Meal)
}

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //MARK: Properties
    @IBOutlet weak var newFoodText: UITextField!
    @IBOutlet weak var cleanButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var saveButton: UIBarButtonItem!
    var meal: Meal?
    var delegate: MealTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSaveButton()
        newFoodText.delegate = self
        spinner.hidesWhenStopped = true
        
        //Preload meal if comes from segue
        if let editingMeal = self.meal {
            fillFieldsWithMeal(meal: editingMeal)
            self.cleanButton.isEnabled = false
            navigationItem.title = "Editando"
        } else {
            navigationItem.title = "Agregar comida"
        }
        checkValidMealName()
    }

    //MARK: Button
    func createSaveButton(){
        saveButton = UIBarButtonItem(title: "Guardar", style: UIBarButtonItemStyle.plain, target: self, action: #selector(saveMeal))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    //MARK: UITextFiledDelegate
    
    func checkValidMealName(){
        let text = newFoodText.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidMealName()
        navigationItem.title = "Agregando \(newFoodText.text!)"
    }

    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    func saveMeal() {
        spinner.isHidden = false
        spinner.startAnimating()
        let newMealName = newFoodText.text!
        let newMealImage = photoImageView.image
            
        meal = Meal(name: newMealName, image: newMealImage)
        delegate!.updateMeal(meal: meal!)
        
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }else{
            navigationController!.popViewController(animated: true)
        }
        spinner.stopAnimating()
    }
    
    
    //MARK: Actions
    @IBAction func cleanInfo(_ sender: UIButton) {
        if self.meal == nil {
            newFoodText.text = ""
            photoImageView.image = UIImage(named: "defaultMeal")
        }
    }
    
    @IBAction func galleryImageTap(_ sender: UITapGestureRecognizer) {
        callPicker(UIImagePickerControllerSourceType.photoLibrary)
    }
    
    @IBAction func photoImageTap(_ sender: UITapGestureRecognizer) {
        callPicker(UIImagePickerControllerSourceType.camera)
    }
    
    func callPicker(_ picker : UIImagePickerControllerSourceType) {
        newFoodText.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = picker
        imagePickerController.delegate = self
        
        present(imagePickerController,animated: true, completion: nil)
    }
    
    
    
    //MARK: Methods
    private func assingText(_ textToAssing: String) {
        newFoodText.text = ""
    }
    
    private func fillFieldsWithMeal(meal: Meal){
        newFoodText.text = meal.name.capitalized
        photoImageView.image = meal.image!
    }
    
}

