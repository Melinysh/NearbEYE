//
//  LoadJSONOperation.swift
//  WellWaterExperiment
//
//  Created by Stephen Melinyshyn on 2015-07-31.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit

class LoadJSONOperation: Operation {

    var fileName : String!
    var json : [String : AnyObject]!
    
    init(fileName : String) {
        super.init()
        self.fileName = fileName
    }
    
    override func execute() {
        guard let filePath = NSBundle.mainBundle().pathForResource(fileName, ofType: "json") else {
            fatalError("No file path found for filename \(fileName).")
        }
        
        let stream = NSInputStream(fileAtPath: filePath)!
        stream.open()
        defer { stream.close() }
        do {
            json = try NSJSONSerialization.JSONObjectWithStream(stream, options: NSJSONReadingOptions.AllowFragments) as! [String: AnyObject]
        } catch {
            fatalError("Error occured opening JSON stream \(error)")
        }
		
		print("Loaded file \(fileName)")
        finish()
    }
}
