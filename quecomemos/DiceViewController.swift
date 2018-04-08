import UIKit

class DiceViewController: BaseViewController, UINavigationControllerDelegate{

    @IBOutlet weak var diceImage: UIImageView!
    
    private let viewModel: DiceViewModel
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = DiceViewModel(meals: FindAllMeals().invoke())
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func throwDices(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.diceImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }, completion: nil )
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            self.diceImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
        }) { isFinished in self.showRandomMeal() }
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


