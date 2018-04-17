import UIKit
import Foundation

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MealTableViewCell
        let meal = meals[indexPath.row]
        cell.mealName.text = meal.name.capitalized
        cell.mealImage.image = meal.image
        
        return cell
    }
}

class MealTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mealName: UILabel! {
        willSet {
            newValue.text = newValue.text?.capitalized
        }
    }
    
    @IBOutlet weak var mealImage: UIImageView!
}
