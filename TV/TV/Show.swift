//
//  Show.swift
//  TV Tracker App
//
//  Created by Michael Thomsen on 1/16/17.
//  Copyright © 2017 Michael Thomsen. All rights reserved.
//

import Foundation
import UIKit
import os.log

class Show: NSObject, NSCoding {
    
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var id: Int
    
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("shows")
    
    
    
    
    //MARK: Types
    
    
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let id = "id"
    }
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, id: Int) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
    
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.id = id

    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(id, forKey: PropertyKey.id)
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Show object.", log: OSLog.default, type: .debug)
            return nil
            
        }
        
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let id = aDecoder.decodeInteger(forKey: PropertyKey.id)
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, id: id)
        
        
    }

    
    
}








    
    

    

