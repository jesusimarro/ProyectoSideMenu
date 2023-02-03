//
//  WebViewController.swift
//  ProyectoSideMenuMapas
//
//  Created by estech on 20/1/23.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var buscarTextField: UITextField!
    
    @IBOutlet weak var rightButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureMainMenu(menuButton: menuButton)
        self.configureRightMenu(rightButton: rightButton)
        
        let url = URL(string: "https://escuelaestech.es")!
        let request = URLRequest(url: url)
        webView.load(request)
        webView.allowsBackForwardNavigationGestures = true
    }
    
    
    @IBAction func forwardButton(_ sender: Any) {
        webView.goForward()
    }
    
    @IBAction func backButton(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func reloadButton(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func buscarAction(_ sender: Any) {
        let pagina = buscarTextField.text!
        
        if pagina.hasPrefix("https://") {
            let url = URL(string: pagina)!
            webView.load(URLRequest(url: url))
        } else {
            let url = URL(string: "https://" + pagina)!
            webView.load(URLRequest(url: url))
        }
    }
    
}
