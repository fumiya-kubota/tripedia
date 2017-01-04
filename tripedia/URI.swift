//
//  URI.swift
//  tripedia
//
//  Created by Fumiya-Kubota on 2017/01/04.
//  Copyright © 2017年 窪田文也. All rights reserved.
//

import Foundation
import RealmSwift

class URI: Object {
    dynamic var uri = ""
    
    override static func primaryKey() -> String? {
        return "uri"
    }
}
