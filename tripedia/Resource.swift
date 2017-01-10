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
    enum `Type` : Int {
        case Resource
        case Property
    }
    dynamic var uri: URI?
    dynamic var type = Type.Resource.rawValue
}
