import UIKit

class CreateMealViewController: UIViewController, UINavigationControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var newFoodName: UITextField!
    @IBOutlet weak var newFoodPlace: UITextField!
    @IBOutlet weak var newFoodDescription: UITextView!
    @IBOutlet weak var newFoodImage: UIImageView!
    @IBOutlet weak var saveButton: EaterButton!
    
    private let createMeal = CreateMeal()
    
    override func viewDidLoad() {
        newFoodName.delegate = self
        newFoodPlace.delegate = self
        newFoodDescription.delegate = self
        newFoodDescription.layer.cornerRadius = Constants.Buttons.borderRadius
        checkValidMealName()
        super.viewDidLoad()
    }
    
    //MARK: UITextFiledDelegate
    func checkValidMealName(){
        let text = newFoodName.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func callPicker(_ picker : UIImagePickerControllerSourceType) {
        newFoodName.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = picker
        imagePickerController.delegate = self
        
        present(imagePickerController,animated: true, completion: nil)
    }
    
    //Buttons tap
    @IBAction func tapCamera(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default) { _ in self.callPicker(.camera) })
        alert.addAction( UIAlertAction(title: "Choose Photo", style: .default) { _ in self.callPicker(.photoLibrary) })
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tapBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSave(_ sender: EaterButton) {
        let newMeal = Meal.create(withName: newFoodName.text!, withImage: newFoodImage.image)
        createMeal.invoke(newMeal)
        dismiss(animated: true, completion: nil)
    }
}

extension CreateMealViewController : UITextFieldDelegate, UITextViewDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidMealName()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        newFoodName.endEditing(true)
        newFoodPlace.endEditing(true)
        newFoodDescription.endEditing(true)
    }
}

extension CreateMealViewController : UIImagePickerControllerDelegate {
   
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        newFoodImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
}
