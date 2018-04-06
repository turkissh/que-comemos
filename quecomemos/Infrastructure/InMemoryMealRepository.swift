import Foundation
import UIKit

class InMemoryMealRepository: MealRepository {
    
    private let archiveURL: URL
    
    init() {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first
        self.archiveURL = (documentsDirectory?.appendingPathComponent("meals"))!
    }
    
    func findAll() -> Set<Meal> {
        let meals = loadMeals() ?? loadSampleMeals()
        return Set(meals)
    }
    
    func save(meal: Meal) {
        var savedMeals = loadMeals() ?? Set()
        savedMeals.insert(meal)
    
        saveMeals(savedMeals)
    }
    
    func remove(meal: Meal) {
        if var meals = loadMeals() {
            meals.remove(meal)
            saveMeals(meals)
        }
    }
    
    private func saveMeals(_ meals: Set<Meal>){
        NSKeyedArchiver.archiveRootObject(meals, toFile: self.archiveURL.path)
    }
    
    private func loadMeals() -> Set<Meal>?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: self.archiveURL.path) as? Set<Meal>
    }
    
    //For testing
    private func loadSampleMeals() -> Set<Meal> {
        let mealExample = Meal.create(withName: "Milanesa", withImage: UIImage(named: "milanesa"))
        let mealExample2 = Meal.create(withName: "Hamburguesa", withImage: UIImage(named: "hamburguesa"))
        return Set(arrayLiteral: mealExample,mealExample2)
    }
}
