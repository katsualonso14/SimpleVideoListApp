import UIKit

class LoginViewController: UIViewController {
    let emailTextField = UITextField()
    let passwordTextField =  UITextField()
    let loginButton = UIButton()
    let videoListVC = VideoListViewController()
    var isLogout = false
    let appViewModel = AppViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupEmailTextField()
        setupPasswordTextField()
        setupLoginButton()
        setupRegisterButton()
        setMailAndPassword()
    }
    //MARK: Layout
    func setupEmailTextField() {
        emailTextField.placeholder = "メールアドレス"
        emailTextField.borderStyle = .roundedRect
        emailTextField.backgroundColor = .systemGray6
        emailTextField.textColor = .black
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailTextField)
        
        NSLayoutConstraint.activate([
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            emailTextField.widthAnchor.constraint(equalToConstant: 300),
            emailTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func setupPasswordTextField() {
        passwordTextField.placeholder = "パスワード"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.textColor = .black
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupLoginButton() {
        loginButton.backgroundColor = .systemBlue
        loginButton.setTitle("ログイン", for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.cornerRadius = 20
        loginButton.layer.masksToBounds = true
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
        registerButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.layer.cornerRadius = 20
        registerButton.layer.masksToBounds = true
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    //MARK: Function
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
        
        let savedEmail = appViewModel.getUserInfo()["email"] as? String
        let savedPassword = appViewModel.getUserInfo()["password"] as? String
        if email == savedEmail && password == savedPassword {
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
        
        // UserDefaults保存
        appViewModel.setUserInfo(email: email, password: password)
        showAlert(message: "登録が完了しました")
    }
    
    // TextFieldへの自動入力
    func setMailAndPassword() {
        // ローカル保存のデータを入力した状態で、再度ログイン画面に
        if let savedEmail = appViewModel.getUserInfo()["email"] as? String {
            emailTextField.text = savedEmail
        }
        if let savedPassword = appViewModel.getUserInfo()["password"] as? String {
            passwordTextField.text = savedPassword
        }
        
    }
}

