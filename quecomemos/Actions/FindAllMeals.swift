import Foundation

class FindAllMeals: BaseAction {
    
    func invoke() -> Set<Meal> {
        return repository.findAll()
    }
    
}
