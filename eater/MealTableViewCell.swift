import UIKit

class MealTableViewCell: UITableViewCell {
    @IBOutlet weak var mealName: UILabel! {
        willSet {
            newValue.text = newValue.text?.capitalized
        }
    }
    @IBOutlet weak var mealImage: UIImageView!
}
