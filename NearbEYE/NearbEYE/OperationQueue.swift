//
//  OperationQueue.swift
//  WellWaterExperiment
//
//  Created by Stephen Melinyshyn on 2015-07-31.
//  Copyright © 2015 Stephen Melinyshyn. All rights reserved.
//

import UIKit

class OperationQueue: NSOperationQueue {
    override func addOperation(operation: NSOperation) {
        if let op = operation as? Operation {
            op.willEnqueue()
        }
        super.addOperation(operation)
    }
    
    override func addOperations(operations: [NSOperation], waitUntilFinished wait: Bool) {
        /*
        The base implementation of this method does not call `addOperation()`,
        so we'll call it ourselves.
        */
        for operation in operations {
            addOperation(operation)
        }
        
        if wait {
            for operation in operations {
                operation.waitUntilFinished()
            }
        }
    }

}
