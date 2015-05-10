//
//  PropertyObserver.swift
//  GuessingGame
//
//  Created by Connor Moreside on 2015-05-10.
//  Copyright (c) 2015 Connor Moreside. All rights reserved.
//

import Foundation

protocol PropertyObserver : class {
    func willChangePropertyName(propertyName:String, newPropertyValue:AnyObject?)
}