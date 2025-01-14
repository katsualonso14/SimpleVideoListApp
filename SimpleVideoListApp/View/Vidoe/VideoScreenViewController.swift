import Foundation
import UIKit
import WebKit

class VideoScreenViewController: UIViewController, WKUIDelegate {
    var id: String = ""
    var webView: WKWebView!
    var urlTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTextField()
        setupWebView()
        setupWebViewLayout()
    }
    
    func setupWebView() {
        let webConfig = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        let url = URL(string: "https://live.fc2.com/\(id)")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    func setupWebViewLayout() {
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: urlTextField.bottomAnchor, constant: 10),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }

    func setupTextField() {
        urlTextField = UITextField()
        urlTextField.placeholder = "Enter URL"
        urlTextField.borderStyle = .roundedRect
        urlTextField.text = "https://live.fc2.com/\(id)"
        view.addSubview(urlTextField)
        
        urlTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            urlTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            urlTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            urlTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            urlTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
