//
//  WebViewController.swift
//  Cocinera
//
//  Created by Jon Alaniz on 2/22/23.
//

import UIKit
import WebKit

/// Reusable view that has a full-screen WKWebView that display web page title in the NavigationBar
class WebViewController: UIViewController {
    weak var coordinator: AuthenicationCoordinator?
    var webView: WKWebView!
    var url: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false

        webView.navigationDelegate = self
        webView.cleanAllCookies()
        webView.load(URLRequest(url: url))
    }
}

extension WebViewController: WKNavigationDelegate {
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.navigationItem.title = webView.title
    }
}

extension WKWebView {
    func cleanAllCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)

        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
    }

    func refreshCookies() {
        self.configuration.processPool = WKProcessPool()
    }
}
