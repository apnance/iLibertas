//
//  ViewController.swift
//  iLibertas
//
//  Created by Aaron Nance on 5/23/22.
//

import APNUtil
import WebKit

typealias URLString = String

class ViewController: UIViewController {
    
    var webView: WKWebView!
    var history = History.shared
    
    @IBAction func tapNavButton(_ sender: Any) {
        
        guard let button = sender as? UIButton
        else { return /*EXIT*/ }
        
        navigate(dir: button.tag)
        
    }
    
    @IBOutlet weak var addressBar: UITextField!
    @IBOutlet weak var navButtonBackward: UIButton!
    @IBOutlet weak var navButtonForeward: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let webVuConfiguration = WKWebViewConfiguration()
        webVuConfiguration.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        webView = WKWebView(frame: view.frame,
                            configuration: webVuConfiguration)
        
        view.addSubview(webView)
        view.sendSubviewToBack(webView)
        
        uiVolatile()
        
    }
    
    fileprivate func loadURLFrom(_ stringURL: URLString) {
        
        if history.loadURL(stringURL) {
            
            navigate()
            
        } else {
            
            webView.loadHTMLString("<br/><br/><br/><br/><div style=\"font-size:30pt; font-weight: bold; text-align:center;\">Invalid URL</div>",
                                   baseURL: nil)
        }
        
        uiVolatile()
        
    }
    
    func loadFromPasteboard() {
        
        if UIPasteboard.general.hasStrings {
            
            if let stringURL = UIPasteboard.general.string {
                
                loadURLFrom(stringURL)
                
            }
            
        }
        
        print(history)
        
    }
    
    fileprivate func navigate(dir: Int! = 1) {
        
        if let url = history.getPage(dir: dir) {
        
            webView.load(URLRequest(url: url))
            
        }
        
        uiVolatile()
        
    }
    
    fileprivate func uiVolatile() {
        
        navButtonBackward.isEnabled = !history.isFirst
        navButtonForeward.isEnabled = !history.isLast
        
        addressBar.text             = history.currentURL
        
    }
    
}

extension ViewController: WKUIDelegate {
    
        func webView(_ webView: WKWebView,
                     createWebViewWith configuration: WKWebViewConfiguration,
                     for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
    
            // Create new WKWebView with custom configuration here
            let webVuConfiguration = WKWebViewConfiguration()
            webVuConfiguration.websiteDataStore = WKWebsiteDataStore.nonPersistent()
    //        webView.configuration = webVuConfiguration
    //        webView.configuration
    
    
            return WKWebView(frame: webView.frame, configuration: webVuConfiguration)
        }
    
}
