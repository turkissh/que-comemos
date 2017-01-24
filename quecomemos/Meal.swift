//
//  Meal.swift
//  quecomemos
//
//  Created by Emiliano Di Pierro on 10/18/16.
//  Copyright © 2016 Emiliano Di Pierro. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    
    //MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let photoKey = "photo"
    }
    
    //MARK: Properties
    var name: String
    var image: UIImage?
    
    //MARK: Save paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first
    static let ArchiveURL = DocumentsDirectory?.appendingPathComponent("meals")
    
    init?(name: String, image: UIImage?) {
        
        //Validation
        if name.isEmpty {
            return nil
        }
        
        self.name = name
        self.image = image
        
        super.init()
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(image, forKey: PropertyKey.photoKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        let image = aDecoder.decodeObject(forKey: PropertyKey.photoKey) as! UIImage
        
        self.init(name: name, image: image)
    }
}
