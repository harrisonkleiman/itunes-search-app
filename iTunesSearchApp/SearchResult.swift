//
//  SearchResult.swift
//  iTunesSearchApp
//
//  Created by Harrison Kleiman on 5/17/22.
//

import Foundation

class SearchResult {
    
    var artistName = ""
    var trackName = ""
    var itemDescription = ""
    var trackPrice = 0.00
    
    init?(json: [String : AnyObject]) {
        guard let artistName = json["artistName"] as? String,
              let trackName = json["trackName"] as? String else { return nil }
        let itemDescription = json["description"]
        let price = json["trackPrice"]
        
        self.artistName = artistName
        self.trackName = trackName
        
        // unwrap track price
        if let trackP = price as? Double {
            self.trackPrice = trackP
        }
        
        if let d = itemDescription as? String {
            self.itemDescription = d
        }
        
        
    }
}
