//
//  DBPediaViewController.swift
//  tripedia
//
//  Created by 窪田文也 on 2016/12/26.
//  Copyright © 2016年 窪田文也. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa
import RxWebKit


class DBPediaViewController: UIViewController {
    var dbpediaURL: URL?
    let webView = WKWebView.init()
    @IBOutlet weak var webViewBase: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var starButton: UIButton!
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.allowsBackForwardNavigationGestures = true
        let isURLStream = webView.rx.url.map { url -> Bool in
            return (url != nil) ? true : false
        }
        isURLStream.subscribe(onNext: {[weak self] (isURL) in
            self?.actionButton.isEnabled = isURL
        }).addDisposableTo(disposeBag)
        Observable.combineLatest(isURLStream, webView.rx.canGoBack) { (isURL, canGoBack) -> Bool in
            return isURL && canGoBack
        }.subscribe(onNext: {[weak self] in
            self?.backButton.isEnabled = $0
        }).addDisposableTo(disposeBag)
        Observable.combineLatest(isURLStream, webView.rx.canGoForward) { (isURL, canGoForward) -> Bool in
            return isURL && canGoForward
            }.subscribe(onNext: {[weak self] in
                self?.forwardButton.isEnabled = $0
        }).addDisposableTo(disposeBag)
        backButton.rx.tap.subscribe(onNext: {[weak self] in
            let _ = self?.webView.goBack()
        }).addDisposableTo(disposeBag)
        forwardButton.rx.tap.subscribe(onNext: {[weak self] in
            let _ = self?.webView.goForward()
        }).addDisposableTo(disposeBag)
        actionButton.rx.tap.subscribe(onNext: {[weak self] in
            if let url = self?.webView.url {
                let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
                self?.present(vc, animated: true, completion: nil)
            }
        }).addDisposableTo(disposeBag)
        
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
        
        if let url = self.dbpediaURL {
            webView.load(URLRequest.init(url: url))
        }
        webView.rx.url.subscribe(onNext: {[weak self] in
            self?.dbpediaURL = $0
        }).addDisposableTo(disposeBag)
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
