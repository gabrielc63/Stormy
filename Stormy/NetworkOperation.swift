//
//  NetworkOperation.swift
//  Stormy
//
//  Created by Gabriel Coronel on 10/11/15.
//  Copyright © 2015 Gabriel Coronel. All rights reserved.
//

import Foundation

class NetworkOperation {
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    
    typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> Void
    
    init(url: NSURL) {
        self.queryURL = url
    }
    
    func downloadJSON(completion: JSONDictionaryCompletion) {
        let request: NSURLRequest = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            
            do {
                let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as! [String: AnyObject]
                completion(jsonDictionary)
            } catch {
                    print("error")
            }
            
        }
        
        dataTask.resume()
    }
}