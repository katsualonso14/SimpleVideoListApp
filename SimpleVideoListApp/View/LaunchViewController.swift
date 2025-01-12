

import Foundation
import UIKit

class LaunchViewController: UIViewController {
    private let viewModel = AppViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigateToScreen()
    }
    
    func navigateToScreen() {
        //初回起動かで遷移先を判定
        if viewModel.checkVisitedBefore() {
            if(viewModel.checkLoginTime()) {
                // 5分以内の再起動: 自動ログイン
                navigateToVideoList()
            } else {
                // ログイン画面に遷移
                navigateToLogin()
            }
        } else {
            // ログイン画面に遷移
            navigateToLogin()
        }
    }
    
    // ビデオ一覧ページに遷移
    func navigateToVideoList() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                let videoListVC = VideoListViewController()
                let navigationController = UINavigationController(rootViewController: videoListVC)
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
            }
        }
    }
    
    // ログイン画面に遷移
    func navigateToLogin() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                let loginVC = LoginViewController()
                let navigationController = UINavigationController(rootViewController: loginVC)
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
            }
        }
    }
}
