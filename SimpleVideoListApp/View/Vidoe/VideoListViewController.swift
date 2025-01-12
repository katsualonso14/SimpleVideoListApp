import Foundation
import UIKit
import RealmSwift
import Combine

class VideoListViewController: UITableViewController {
    let imageViewModel = ImageViewModel()
    var videoItems: [VideoItem] = []
    let videoViewModel = VideoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNaviBar()
        setupVideoListTableView()
        // データ取得
        videoViewModel.getData { [weak self] items in
            DispatchQueue.main.async {
                self?.videoItems = items
                self?.tableView.reloadData()
            }
        }
        
    }
    // MARK: Layout
    func setupNaviBar() {
        navigationItem.title = "動画一覧"
        navigationController?.navigationBar.prefersLargeTitles = true
        let backButtonItem = UIBarButtonItem(title: "戻る", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.rightBarButtonItem = backButtonItem
    }
    func setupVideoListTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(VideoCell.self, forCellReuseIdentifier: "cell")
    }
    //MARK: - Tableview
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoItems.count
    }
    // Cellの設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! VideoCell
        let videoItem = videoItems[indexPath.row]
        cell.titleLabel.text = videoItem.title
        cell.nameLabel.text = videoItem.name
        cell.idLabel.text = videoItem.id
        // 画像取得
        if let url = URL(string: videoItem.image) {
            imageViewModel.fetchImage(from: url) { image in
                DispatchQueue.main.async {
                    cell.image.image = image
                    cell.activityIndicator.stopAnimating()
                }
            }
        }
        return cell
    }
    // タップ時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("id: \(videoItems[indexPath.row].id)") // 確認用
        let videoScreenViewController = VideoScreenViewController()
        videoScreenViewController.id = videoItems[indexPath.row].id
        navigationController?.pushViewController(videoScreenViewController, animated: true)
    }
    // MARK: - Function
    // エラーアラート表示
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    //login画面に戻る【確認用】
    @objc func backButtonTapped() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                let loginController = LoginViewController()
                // 戻るボタンで戻った場合のみログアウトフラグを立てる
                loginController.isLogout = true
                window.rootViewController = loginController
                window.makeKeyAndVisible()
            }
        }
    }
}
