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
        urlTextField.frame = CGRect(x: 20, y: 130, width: self.view.frame.width - 40, height: 40)
        urlTextField.placeholder = "Enter URL"
        urlTextField.borderStyle = .roundedRect
        urlTextField.text = "https://live.fc2.com/\(id)"
        // WebViewを再読み込み
        urlTextField.addTarget(self, action: #selector(reloadWebView), for: .editingChanged)
        view.addSubview(urlTextField)

    }
    
    @objc func reloadWebView() {
        if let url = URL(string: urlTextField.text ?? "") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
