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
    dynamic var first = SparqlVariable()
    dynamic var second = SparqlVariable()
    dynamic var third = SparqlVariable()
}

class Sparql: Object {
    let select = List<SparqlVariable>()
    let triples = List<SparqlTriple>()
}
