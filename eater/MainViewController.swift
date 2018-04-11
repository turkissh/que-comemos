import UIKit

class MainViewController: BaseViewController, UINavigationControllerDelegate{
    
    @IBOutlet weak var decideForMeButton: UIButton!
    
    private let viewModel: DiceViewModel
    
    //MARK: Setup
    required init?(coder aDecoder: NSCoder) {
        self.viewModel = DiceViewModel(meals: FindAllMeals().invoke())
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        setButton()
        super.viewDidLoad()
    }
    
    private func setButton() {
        decideForMeButton.backgroundColor = Constants.Colors.greenButtonColor
        decideForMeButton.layer.cornerRadius = Constants.Buttons.borderRadius
        decideForMeButton.layer.borderWidth = Constants.Buttons.borderWidth
        decideForMeButton.layer.borderColor = UIColor.white.cgColor
    }
    
    //MARK: Actions
    @IBAction func tapDecide(_ sender: UIButton) {
        self.showRandomMeal()
    }
    
    private func showRandomMeal() {
        if viewModel.hasMeals() {
            performSegue(withIdentifier: "modalMealSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modalMealSegue" {
            if let destination = segue.destination as? ModalMealViewController {
                let randomMeal = viewModel.getRandomMeal()
                destination.newMealName = randomMeal!.name
                destination.newMealImage = randomMeal!.image
            }
        }
    }

}


