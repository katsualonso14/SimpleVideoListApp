
import UIKit

import UIKit

class LoginController: UIViewController {
    let emailTextField = UITextField()
    let passwordTextField =  UITextField()
    let loginButton = UIButton()
    let videoListVC = VideoListViewController()
    var isLogout = false

    //TODO: センターへの配置設定,関数のディレクトリ変更, アプリっぽいUIへの変更
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupRegisterButton()
        // 自動ログイン
        autoLoginCheck()
    }
    
    func setupEmailTextField() {
        emailTextField.placeholder = "メールアドレス"
        emailTextField.borderStyle = .roundedRect
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    //MARK: Layouot
    func setupPasswordTextField() {
        passwordTextField.placeholder = "パスワード"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupLoginButton() {
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitle("ログイン", for: .normal)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            loginButton.widthAnchor.constraint(equalToConstant: 200),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupRegisterButton() {
        let registerButton = UIButton()
        registerButton.backgroundColor = .systemGreen
        registerButton.setTitle("新規登録", for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    //MARK: Function
    // 自動ログイン
    func autoLoginCheck() {
        // UserDefaultsの時間チェック
        if let lastLoginTime = UserDefaults.standard.value(forKey: "lastLoginTime") as? TimeInterval {
            let currentTime = Date().timeIntervalSince1970
            let timeDifference = currentTime - lastLoginTime
            print("timeDifference: \(timeDifference)")
            // アプリ起動の5分チェック
            if (timeDifference <= 300 && isLogout == false) {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    if let window = windowScene.windows.first {
                        let navigationController = UINavigationController(rootViewController: videoListVC)
                        window.rootViewController = navigationController
                        window.makeKeyAndVisible()
                    }
                }
                print("自動ログイン成功")//確認用
            }
            else {
                // ローカル保存のデータを入力した状態で、再度ログイン画面に
                if let savedEmail = UserDefaults.standard.string(forKey: "email") {
                    emailTextField.text = savedEmail
                }
                if let savedPassword = UserDefaults.standard.string(forKey: "password") {
                    passwordTextField.text = savedPassword
                }
                print("自動ログイン失敗") //確認用
            }
        }
    }
    
    //MARK: Action
    @objc func loginButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Emailとパスワードを入力してください。")
            return
        }
        
        if !isValidEmail(email) {
            showAlert(message: "正しいEmailアドレスを入力してください。")
            return
        }
        
        // UserDefaults確認
        let savedEmail = UserDefaults.standard.string(forKey: "email")
        let savedPassword = UserDefaults.standard.string(forKey: "password")
        
        // UserDefaultsのチェック
        if email == savedEmail && password == savedPassword {
            // UserDefaults保存
            let currentTime = Date().timeIntervalSince1970
            UserDefaults.standard.set(currentTime, forKey: "lastLoginTime")
            
            //遷移
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = windowScene.windows.first {
                    let navigationController = UINavigationController(rootViewController: videoListVC)
                    window.rootViewController = navigationController
                    window.makeKeyAndVisible()
                }
            }
            
            print("手動のログイン成功") //確認用
        } else {
            showAlert(message: "Emailかパスワードが間違っています。")
        }
    }
      
    // 登録ボタンがタップされたときの処理
    @objc func registerButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Emailとパスワードを入力してください。")
            return
        }
        
        if !isValidEmail(email) {
            showAlert(message: "正しいEmailアドレスを入力してください。")
            return
        }
        
        // UserDefaultsへの保存
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
        let currentTime = Date().timeIntervalSince1970
        UserDefaults.standard.set(currentTime, forKey: "lastLoginTime")
        
        showAlert(message: "登録が完了しました")
    }
    
    // アラートダイアログ表示
    func showAlert(message: String) {
        // 自動ログインチェック用にメインスレッドで処理
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "アラート", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    // メールアドレスの形式チェック
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
}

