//
//  Meal.swift
//  quecomemos
//
//  Created by Emiliano Di Pierro on 10/18/16.
//  Copyright © 2016 Emiliano Di Pierro. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    
    //MARK: Properties
    let uuid: String
    var name: String
    var image: UIImage?
    
    static func create(withName name: String, withImage image: UIImage?) -> Meal {
        return Meal(uuid: NSUUID().uuidString, name: name, image: image)!
    }
    
    init?(uuid: String, name: String, image: UIImage?) {
        //Validation
        guard !name.isEmpty else { return nil }
        
        self.uuid = uuid
        self.name = name
        self.image = image
        super.init()
    }
    
    //MARK: NSCoding
    struct PropertyKey {
        static let uuidKey = "u"
        static let nameKey = "n"
        static let photoKey = "p"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uuid, forKey: PropertyKey.uuidKey)
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(image, forKey: PropertyKey.photoKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let uuid = aDecoder.decodeObject(forKey: PropertyKey.uuidKey) as! String
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let image = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as! UIImage
        
        self.init(uuid: uuid, name: name, image: image)
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let meal = object as? Meal {
            return uuid == meal.uuid
        } else {
            return false
        }
    }
    
    override var hashValue: Int {
        return uuid.hashValue
    }
}
