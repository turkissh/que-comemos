import Foundation

protocol MealRepository {
    
    func findAll() -> Set<Meal>
    
    func save(meal: Meal)
    
    func remove(meal: Meal)
}
