
import UIKit

import UIKit

class ViewController: UIViewController {
    let emailTextField = UITextField()
    let passwordTextField =  UITextField()
    let loginButton = UIButton()

    //TODO: センターへの配置設定,関数のディレクトリ変更, アプリっぽいUIへの変更
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupRegisterButton()
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
    
    //MARK: Action
    @objc func loginButtonTapped() {
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Emailとパスワードを入力してください。")
            return
        }
        
        // Emailの形式を検証
        if !isValidEmail(email) {
            showAlert(message: "正しいEmailアドレスを入力してください。")
            return
        }
        
        // UserDefaults確認
        let savedEmail = UserDefaults.standard.string(forKey: "email")
        let savedPassword = UserDefaults.standard.string(forKey: "password")
        
        // UserDefaultsのチェック
        if email == savedEmail && password == savedPassword {
            showAlert(message: "ログイン成功")
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
        
        // Emailの形式を検証
        if !isValidEmail(email) {
            showAlert(message: "正しいEmailアドレスを入力してください。")
            return
        }
        
        // UserDefaultsにEmailとパスワードを保存
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
        
        showAlert(message: "登録が完了しました")
    }
    
    // アラートダイアログ表示
    func showAlert(message: String) {
        let alert = UIAlertController(title: "アラート", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // メールアドレスの形式チェック
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
}

