//
//  resource.swift
//  tripedia
//
//  Created by Fumiya-Kubota on 2017/01/04.
//  Copyright © 2017年 窪田文也. All rights reserved.
//

import Foundation
import RealmSwift

class Resource: Object {
    enum `Type` : String {
        case Resource = "Resource"
        case Property = "Property"
    }
    dynamic var uri = URI()
    dynamic var type: String = Type.Resource.rawValue
}

class StockResources: Object {
    let resources = List<Resource>()
}
