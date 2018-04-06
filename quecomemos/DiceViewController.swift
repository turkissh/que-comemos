import UIKit

class DiceViewController: BaseViewController, UINavigationControllerDelegate{

    @IBOutlet weak var diceImage: UIImageView!
    
    private let findAllMeals = FindAllMeals()
    private var randomMeal: Meal?
    
    @IBAction func throwDices(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
            self.diceImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        }, completion: nil )
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            self.diceImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
        }) { isFinished in self.showRandomMeal() }
    }
    
    private func showRandomMeal() {
        let meals = findAllMeals.invoke()

        if !meals.isEmpty {
            randomMeal = meals.randomElement()
            performSegue(withIdentifier: "modalMealSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modalMealSegue" && randomMeal != nil {
            if let destination = segue.destination as? ModalMealViewController {
                destination.newMealName = randomMeal!.name
                destination.newMealImage = randomMeal!.image
            }
        }
    }

}

extension Set {
    public func randomElement() -> Element? {
        let n = Int(arc4random_uniform(UInt32(self.count)))
        let index = self.index(self.startIndex, offsetBy: n)
        return self.count > 0 ? self[index] : nil
    }
}
