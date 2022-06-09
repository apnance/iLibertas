//
//  ViewController.swift
//  iLibertas
//
//  Created by Aaron Nance on 5/23/22.
//

import APNUtils
import WebKit

class ViewController: UIViewController {
    
    var webView: WKWebView!
    var history         = [String]()
    var _historicIndex  = 0
    
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
    
    fileprivate func loadURLFrom(_ stringURL: String) {
        
        if let url = URL(string: stringURL),
           url.scheme != nil,
           url.scheme!.contains("http") {
            
            if !history.contains(stringURL) {
                
                history.append(stringURL)
                _historicIndex = history.lastUsableIndex
                
                navigate(dir: 1)
                
            }
            
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
        
        _historicIndex  += dir
        _historicIndex  = min(history.lastUsableIndex, _historicIndex)
        _historicIndex  = max(_historicIndex, 0)
        
        let url         = URL(string: history[_historicIndex])!
        
        print("Index: \(_historicIndex) - URL: \(history[_historicIndex])")
        
        webView.load(URLRequest(url: url))
        uiVolatile()
        
    }
    
    fileprivate func uiVolatile() {
        
        navButtonBackward.isEnabled = _historicIndex > 0
        navButtonForeward.isEnabled = _historicIndex < history.lastUsableIndex
        
        addressBar.text             = history.last ?? ""
        
    }
    
}

extension ViewController: WKUIDelegate {
    
    //    func webView(_ webView: WKWebView,
    //                 createWebViewWith configuration: WKWebViewConfiguration,
    //                 for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
    //
    //        // Create new WKWebView with custom configuration here
    //        let webVuConfiguration = WKWebViewConfiguration()
    //        webVuConfiguration.websiteDataStore = WKWebsiteDataStore.nonPersistent()
    ////        webView.configuration = webVuConfiguration
    ////        webView.configuration
    //
    //
    //        return WKWebView(frame: webView.frame, configuration: webVuConfiguration)
    //    }
    
}
