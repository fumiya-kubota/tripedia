//
//  URLTests.swift
//  tripedia
//
//  Created by 窪田文也 on 2016/12/26.
//  Copyright © 2016年 窪田文也. All rights reserved.
//

import XCTest
import Foundation
@testable import tripedia


class URLTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let ichiro = "https://ja.wikipedia.org/wiki/%E3%82%A4%E3%83%81%E3%83%AD%E3%83%BC"
        let url = URL.init(string: ichiro)!
        let pageName = url.pageName
        XCTAssertEqual("イチロー", pageName)
    }
    
}
