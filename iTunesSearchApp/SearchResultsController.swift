//
//  SearchResultsController.swift
//  iTunesSearchApp
//
//  Created by Harrison Kleiman on 5/17/22.
//

import Foundation

class SearchResultController {
    
    // Hit URL
    static func searchResultsForSearchTerm(searchTerm: String, completion: @escaping (_ results: [SearchResult]?) -> Void) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)"
        //Convert urlString into actual URL
        guard let url = URL(string: urlString) else {
            return
       }
        
        fetchJSONAtURL(url: url) { (json) in
            // Unwrap json
            guard let j = json,
                    let allResults = j["results"] as? [[String : AnyObject]] else { return }
            // Use flatmap closure to convert dictionaries into search result objects
            let searchResults = allResults.compactMap({ return SearchResult(json: $0) }) // $0 is the first input parameter
            completion(searchResults)
        }
    }
    
    static func fetchJSONAtURL(url: URL, completion: @escaping (_ json: [String: AnyObject]?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let e = error {
                print("Error downloading data \(e)")
            } else if let d = data { // data is optional... unwrap data
                do {
                    if let json = try JSONSerialization.jsonObject(with: d, options: []) as? [String : AnyObject] {
                        completion(json)
                    }
                  } catch let jsonError {
                      print("Error decoding JSON \(jsonError)")
                }
            }
        }
        task.resume()
    }
}
