//
//  sparql.swift
//  tripedia
//
//  Created by Fumiya-Kubota on 2017/01/04.
//  Copyright © 2017年 窪田文也. All rights reserved.
//

import Foundation
import RealmSwift

class SparqlVariable: Object {
    dynamic var name = ""
}

class SparqlResource: Object {
    dynamic var uri: URI?
    dynamic var variable: SparqlVariable?
}

class SparqlTriple: Object {
    dynamic var first: SparqlResource?
    dynamic var second: SparqlResource?
    dynamic var third: SparqlResource?
}

class Sparql: Object {
    var select: [String] {
        get {
            return _select.map { $0.name }
        }
        set {
            _select.removeAll()
            _select.append(objectsIn: newValue.map({ SparqlVariable(value: [$0]) }))
        }
    }
    override static func ignoredProperties() -> [String] {
        return ["select"]
    }
    let _select = List<SparqlVariable>()
    let triples = List<SparqlTriple>()
}
