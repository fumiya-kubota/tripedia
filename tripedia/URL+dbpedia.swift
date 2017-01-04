//
//  URL+dbpedia.swift
//  tripedia
//
//  Created by 窪田文也 on 2016/12/26.
//  Copyright © 2016年 窪田文也. All rights reserved.
//

import Foundation


extension URL {
    var pageName:String? {
        let path = self.path
        do {
            let re = try NSRegularExpression.init(pattern: "/((page)|(wiki))/(.+)", options: .caseInsensitive)
            guard let match = re.firstMatch(in: path, options: [], range: .init(location: 0, length: path.characters.count)) else {
                return nil
            }
            let str = path as NSString
            return str.substring(with: match.rangeAt(4)) as String
        } catch let error {
            print(error)
            return nil
        }
    }

    var dbpediaURL:URL? {
        guard let pageName = self.pageName else {
            return nil
        }
        return URL.init(string: "http://ja.dbpedia.org/page/\(pageName.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!)")
    }
    
    var wikipediaURL:URL? {
        guard let pageName = self.pageName else {
            return nil
        }
        return URL.init(string: "https://ja.wikipedia.org/wiki/\(pageName.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!)")
    }
}
