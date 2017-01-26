//
//  Episode.swift
//  TV Tracker App
//
//  Created by Michael Thomsen on 1/21/17.
//  Copyright © 2017 Michael Thomsen. All rights reserved.
//




import Foundation
import UIKit
import os.log

class Episode: NSObject, NSCoding {
    
    
    //MARK: Properties
    
    var name: String
    var season: Int
    var id: Int
    var photo: String
    var summary: String
    var showid: Int
    var episodeNumber: Int
    
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("episodes")
    
    
    
    
    //MARK: Types
    
    
    
    struct PropertyKey {
        static let name = "name"
        static let season = "season"
        static let id = "id"
        static let photo = "photo"
        static let summary = "summary"
        static let showid = "showid"
        static let episodeNumber = "episodeNumber"
    }
    
    //MARK: Initialization
    
    init?(name: String, season: Int, id: Int, photo: String, summary: String, showid: Int, episodeNumber: Int) {
        
        // Initialize stored properties.
        
        // The id must not be empty
        if id == 0 {
         return nil
        } else {
            
            self.showid = showid
            self.name = name
            self.season = season
            self.summary = summary
            self.id = id
            self.photo = photo
            self.episodeNumber = episodeNumber
            
            
        }
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(season, forKey: PropertyKey.season)
        aCoder.encode(id, forKey: PropertyKey.id)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(summary, forKey: PropertyKey.summary)
        aCoder.encode(showid, forKey: PropertyKey.showid)
        aCoder.encode(episodeNumber, forKey: PropertyKey.episodeNumber)
        
    }
    
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // FOR LATER - MAKE ONE OF THESE REQUIRED CONDITIONALLY LIKE IN SHOW?
        
        let id = aDecoder.decodeInteger(forKey: PropertyKey.id)
        
        let season = aDecoder.decodeInteger(forKey: PropertyKey.season)
        
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? String
        
        let summary = aDecoder.decodeObject(forKey: PropertyKey.summary) as? String
        
        let showid = aDecoder.decodeInteger(forKey: PropertyKey.showid)
        
        let episodeNumber = aDecoder.decodeInteger(forKey: PropertyKey.episodeNumber)
        
        // Must call designated initializer.
        self.init(name: name!, season: season, id: id, photo: photo!, summary: summary!, showid: showid, episodeNumber: episodeNumber)
        
        
    }
    
    
    
}







