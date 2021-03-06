//
//  ViewController.swift
//  tripedia
//
//  Created by 窪田文也 on 2016/12/22.
//  Copyright © 2016年 窪田文也. All rights reserved.
//

import UIKit
import WebKit
import FontAwesome_swift
import RxSwift
import RxCocoa
import RxWebKit


class ViewController: UIViewController, WKNavigationDelegate {
    let webView = WKWebView.init()

    @IBOutlet weak var webViewBase: UIView!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var starButton: UIButton!

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        
        webView.rx.url.subscribe(onNext: {[weak self] in
            guard let url = $0 else {
                self?.title = ""
                return
            }
            guard let pageName = url.pageName else {
                self?.title = url.absoluteString
                return
            }
            self?.title = pageName
        }).addDisposableTo(disposeBag)
        
        webView.load(URLRequest.init(url: URL.init(string: "https://ja.m.wikipedia.org/wiki/%E3%83%A1%E3%82%A4%E3%83%B3%E3%83%9A%E3%83%BC%E3%82%B8")!))
    }

    override func loadView() {
        super.loadView()
        webViewBase.addSubview(webView)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        updateToolBarButtons()
    }
    
    func updateToolBarButtons() {
        if let _ = webView.url {
            actionButton.isEnabled = true
        } else {
            actionButton.isEnabled = false
        }
        self.backButton.isEnabled = webView.canGoBack
        self.forwardButton.isEnabled = webView.canGoForward
    }
    
    @IBAction func backButtonPushed(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func forwardButtonPushed(_ sender: Any) {
        webView.goForward()
    }

    @IBAction func actionButtonPushed(_ sender: UIBarButtonItem) {
        if let url = webView.url {
            let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
            present(vc, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = CGRect.init(x: 0, y: 0, width: webViewBase.frame.width, height: webViewBase.frame.height)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dbpedia" {
            let dest = (segue.destination as! UINavigationController).topViewController as! DBPediaViewController
            guard let url = webView.url else {
                return
            }
            dest.dbpediaURL = url.dbpediaURL
        }
    }

    @IBAction func returnAction(for segue: UIStoryboardSegue) {
        if (segue.identifier == "wikipedia") {
            let vc = segue.source as! DBPediaViewController
            guard let url = vc.dbpediaURL else {
                return
            }
            guard let wikipediaURL = url.wikipediaURL else {
                return
            }
            if (webView.url != wikipediaURL) {
                webView.load(.init(url: wikipediaURL))
            }
        }
    }
}
