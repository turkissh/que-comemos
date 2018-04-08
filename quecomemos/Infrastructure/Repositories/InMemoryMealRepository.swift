import Foundation
import UIKit

class InMemoryMealRepository: MealRepository {
    
    private let archiveURL: URL
    
    init() {
        let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first
        self.archiveURL = (documentsDirectory?.appendingPathComponent("meals"))!
    }
    
    func findAll() -> Set<Meal> {
        return loadMeals() ?? loadSampleMeals()
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
        let mealsRepresentation = meals.setmap { MealModel.from(meal: $0) }
        NSKeyedArchiver.archiveRootObject(mealsRepresentation, toFile: self.archiveURL.path)
    }
    
    private func loadMeals() -> Set<Meal>?{
        let mealsRepresentation = NSKeyedUnarchiver.unarchiveObject(withFile: self.archiveURL.path) as? Set<MealModel>
        return mealsRepresentation?.setmap { Meal(uuid: $0.uuid, name: $0.name, image: $0.image)! }
    }
    
    //For testing
    private func loadSampleMeals() -> Set<Meal> {
        let mealExample = Meal.create(withName: "Milanesa", withImage: UIImage(named: "milanesa"))
        let mealExample2 = Meal.create(withName: "Hamburguesa", withImage: UIImage(named: "hamburguesa"))
        return Set(arrayLiteral: mealExample,mealExample2)
    }
}

extension Set {
    func setmap<U>(transform: (Element) -> U) -> Set<U> {
        return Set<U>(self.lazy.map(transform))
    }
}
