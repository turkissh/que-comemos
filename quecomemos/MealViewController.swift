//
//  MealViewController.swift
//  quecomemos
//
//  Created by Emiliano Di Pierro on 10/13/16.
//  Copyright © 2016 Emiliano Di Pierro. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //MARK: Properties
    @IBOutlet weak var newFoodText: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cleanButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newFoodText.delegate = self
        
        //Preload meal if comes from segue
        if let editingMeal = self.meal {
            fillFieldsWithMeal(meal: editingMeal)
            self.cleanButton.isEnabled = false
            navigationB.title = "Editing"
        } else {
            navigationItem.title = "Add meal"
        }
        checkValidMealName()
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
        navigationItem.title = "Adding \(newFoodText.text!)"
    }

    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender as! UIBarButtonItem == saveButton {
            let newMealName = newFoodText.text ?? "Comida"
            let newMealImage = photoImageView.image
            
            meal = Meal(name: newMealName, image: newMealImage)
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
                dismiss(animated: true, completion: nil)
        }else{
            navigationController!.popViewController(animated: true)
        }
        
    }
    
    //MARK: Actions
    @IBAction func cleanInfo(_ sender: UIButton) {
        if self.meal == nil {
            newFoodText.text = ""
            photoImageView.image = UIImage(named: "defaultMeal")
        }
    }
    
    
    @IBAction func galleryImageTap(_ sender: UITapGestureRecognizer) {
        print("Opening gallery")
        callPicker(UIImagePickerControllerSourceType.photoLibrary)
    }
    
    @IBAction func photoImageTap(_ sender: UITapGestureRecognizer) {
        print("Opening picker")
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
        newFoodText.text = meal.name
        photoImageView.image = meal.image!
    }
    
}

