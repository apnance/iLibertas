//
//  ViewController.swift
//  iLibertas
//
//  Created by Aaron Nance on 5/23/22.
//

import APNUtils
import WebKit

class ViewController: UIViewController {
    
    @IBAction func tapButton(_ sender: Any) {
        
        UIPasteboard.general.string = randomURL()
        
        loadFromPastboard()
        
    }
    
    @IBOutlet weak var addressBar: UITextField!
    var webView: WKWebView!
    override func viewDidLoad() {
        
        super.viewDidLoad()

        let webVuConfiguration = WKWebViewConfiguration()
        webVuConfiguration.websiteDataStore = WKWebsiteDataStore.nonPersistent()
        webView = WKWebView(frame: view.frame,
                            configuration: webVuConfiguration)
        
        view.addSubview(webView)
        view.sendSubviewToBack(webView)
                
    }
    
    
    func randomURL() -> String {
        
        let urls = [
            "https://www.seattletimes.com/seattle-news/northwest/public-tours-resume-at-historic-eastern-wa-nuclear-reactor-where-the-atomic-age-began/",
            "https://www.seattletimes.com/seattle-news/politics/former-bothell-mayor-gop-gubernatorial-candidate-joshua-freed-accused-of-misleading-real-estate-investors/",
            "https://www.seattletimes.com/life/food-drink/recipe-dal-with-curry-leaves/",
            "https://www.seattletimes.com/nation-world/nation-politics/kellyanne-conway-trashes-shrewd-and-calculating-jared-kushner-in-new-tell-all-memoir/",
            "https://www.seattletimes.com/nation-world/nation/former-state-ag-due-in-court-for-alleged-probation-violation/",
            "https://www.seattletimes.com/opinion/americas-growing-fault-lines/",
            "https://www.seattletimes.com/opinion/the-pack-has-the-lone-wolfs-back/",
            "https://www.seattletimes.com/seattle-news/politics/we-asked-readers-how-roe-v-wade-has-affected-their-lives-here-are-your-stories/",
            "https://www.seattletimes.com/business/starbucks-officially-leaving-russia-closing-130-stores/",
            "https://www.seattletimes.com/business/redoing-pacific-place-as-offices-is-only-the-start-to-a-downtown-comeback/"
        ]
        
        
        return urls.randomElement!
    
    }
    
    func loadFromPastboard() {
        
        if UIPasteboard.general.hasStrings {
            
            print(UIPasteboard.general.string ?? "-?-")
            
            if let url = URL(string: UIPasteboard.general.string!) {
                
                print(url)
                
                let request = URLRequest(url: url)
                webView.load(request)
                addressBar.text = url.description
                
            } else {
                
                webView.loadHTMLString("<div style=\"font-size:30pt; font-weight: bold; text-align:center;\">Invalid URL</div>", baseURL: nil)
                
            }
            
        } else if UIPasteboard.general.hasURLs {
            
            print(UIPasteboard.general.url?.description ?? "-URL?-")
            
        }
        
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
