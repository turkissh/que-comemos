import Foundation
import UIKit

class MealModel: NSObject, NSCoding {
    
    //MARK: Properties
    let uuid: String
    let name: String
    let place: String
    let notes: String
    let image: UIImage
    
    static func from(meal: Meal) -> MealModel {
        return MealModel(uuid: meal.uuid, name: meal.name, place: meal.place, notes: meal.notes, image: meal.image!)
    }
    
    private init(uuid: String, name: String, place: String, notes: String, image: UIImage) {
        self.uuid = uuid
        self.name = name
        self.place = place
        self.notes = notes
        self.image = image
        super.init()
    }
    
    //MARK: NSCoding
    struct PropertyKey {
        static let uuidKey = "u"
        static let nameKey = "n"
        static let placeKey = "p"
        static let notesKey = "nt"
        static let imageKey = "i"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uuid, forKey: PropertyKey.uuidKey)
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(place, forKey: PropertyKey.placeKey)
        aCoder.encode(notes, forKey: PropertyKey.notesKey)
        aCoder.encode(image, forKey: PropertyKey.imageKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let uuid = aDecoder.decodeObject(forKey: PropertyKey.uuidKey) as! String
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let place = aDecoder.decodeObject(forKey: PropertyKey.placeKey) as! String
        let notes = aDecoder.decodeObject(forKey: PropertyKey.notesKey) as! String
        let image = aDecoder.decodeObject(forKey: PropertyKey.imageKey) as! UIImage
        
        self.init(uuid: uuid, name: name, place: place, notes: notes, image: image)
    }
    
}
