//
//  DBPediaViewController.swift
//  tripedia
//
//  Created by 窪田文也 on 2016/12/26.
//  Copyright © 2016年 窪田文也. All rights reserved.
//

import UIKit
import WebKit

class DBPediaViewController: UIViewController {
    var dbpediaURL: URL?
    let webView = WKWebView.init()
    @IBOutlet weak var webViewBase: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let url = self.dbpediaURL {
            webView.load(URLRequest.init(url: url))
        }
    }
    
    override func loadView() {
        super.loadView()
        webViewBase.addSubview(webView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = CGRect.init(x: 0, y: 0, width: webViewBase.frame.width, height: webViewBase.frame.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
