import Foundation
import UIKit

class LaunchViewController: UIViewController {
    private let viewModel = AppViewModel()
    private let loginCheckViewModel = LoginCheckViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigateToScreen()
    }
    
    func navigateToScreen() {
        //初回起動で遷移先を判定
        if viewModel.checkVisitedBefore() {
            if(loginCheckViewModel.checkLoginTime()) {
                // 5分以内の再起動: 自動ログイン
                navigateToVideoList()
            } else {
                navigateToLogin() // ログイン画面に遷移
            }
        } else {
            navigateToLogin() // ログイン画面に遷移
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
