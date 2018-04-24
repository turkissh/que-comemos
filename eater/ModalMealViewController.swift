import UIKit

class ModalMealViewController: BaseViewController {

    @IBOutlet weak var mealView: UIView!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealPlace: UILabel!
    @IBOutlet weak var mealDescription: UILabel!
    
    var newMealName : String?
    var newMealImage : UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        mealView.layer.cornerRadius = Constants.Buttons.borderRadius
        
        mealName.text = newMealName
        mealImage.image = newMealImage
        mealPlace.text = "Un lugar"
        mealDescription.text = "esta es alta descripcion wachin anda a comer"
    }
    
    @IBAction func dismissTapped(_ sender: EaterButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
