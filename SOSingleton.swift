//
//  SOSingleton.swift
//  MapViewTest
//
//  Created by lostin1 on 2015. 3. 25..
//  Copyright (c) 2015년 lostin. All rights reserved.
//

import Foundation
import CoreLocation

class SOSingleton:NSObject {
    var longtitude:NSNumber?
    var latitude:NSNumber?
    override init() {
        longtitude = NSNumber(float: Float(NSNotFound))
        latitude = NSNumber(float: Float(NSNotFound))
        super.init()
    }
    
    class var getSharedInstance:SOSingleton {
        struct Static {
            static var instance:SOSingleton?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = SOSingleton()
        }
        return Static.instance!
    }
}