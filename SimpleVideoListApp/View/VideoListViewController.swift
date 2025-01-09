

import Foundation
import UIKit
import RealmSwift

class VideoListViewController: UITableViewController {
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var movieTitleList: [String] = []
    var movieNameList: [String] = []
    var movieIdList: [String] = []
    var movieImageList: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
//        readApiConect()
        
    }
    
    // MARK: Layout
    func setupUI() {
        // Activity Indicatorの設定
        //TODO: 画像のみにInndicatorを適用に変更する
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        // TableViewの設定
        tableView.register(MovieCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupMovieListTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setupCheckApiButton() {
        let checkApiButton = UIButton()
        checkApiButton.backgroundColor = .systemPink
        checkApiButton.setTitle("API接続確認", for: .normal)
        checkApiButton.translatesAutoresizingMaskIntoConstraints = false
        checkApiButton.addTarget(self, action: #selector(readApiConect), for: .touchUpInside)
        view.addSubview(checkApiButton)
        
        NSLayoutConstraint.activate([
            checkApiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkApiButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            checkApiButton.widthAnchor.constraint(equalToConstant: 300),
            checkApiButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupBackButton() {
        let backButton = UIButton()
        backButton.backgroundColor = .systemBlue
        backButton.setTitle("戻る", for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            backButton.widthAnchor.constraint(equalToConstant: 300),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    //MARK: - API
    // API読み込み
    @objc func readApiConect() {
        // API URL
        let url = URL(string: "https://live.fc2.com/contents/allchannellist.php")!
        // URLリクエスト
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error occurred: \(error)")
                return
            }
            if let data = data {
                do {
                    // JSONのデコード
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    DispatchQueue.main.async {
                          self.checkUrlRequestContents(json: json)
                          self.activityIndicator.stopAnimating()
                      }
                } catch {
                    print("Failed to parse JSON: \(error)")
                }
            }
        }.resume()

        print("APIリクエスト開始") // 確認用
    }
    
    //　Jsonの内容をチェック
    func checkUrlRequestContents(json: Any) {
        print("tap")
        if let json = json as? [String: Any] {
            
            if let contents = json["channel"] as? [[String: Any]] {
                let videoItems = contents.map { content -> VideoItem in
                    let videoItem = VideoItem()
                    videoItem.title = content["title"] as? String ?? ""
                    videoItem.name = content["name"] as? String ?? ""
                    videoItem.id = content["id"] as? String ?? ""
//                    videoItem.image = content["image"] as? Data ?? Data()
                    videoItem.image = content["image"] as? String ?? ""
                    return videoItem
                }
                
                // Reamlに保存
                let realm = try! Realm()
                try! realm.write {
                    realm.add(videoItems)
                }
                
                
            }
            // TableViewをリロード
                  tableView.reloadData()
        }

        print(movieImageList.first ?? "test")
    }
    //MARK: - Realm
    //Realm読み込み 【確認用】
    func realmRead() {
        let realm = try! Realm()
        let videoItems = realm.objects(VideoItem.self)
        
        print("videoItems count: \(videoItems.count)")
        print("videoItems: \(videoItems)")
        
        print("Realmから読み込みました")
    }
    
    //Realmデータ削除 【確認用】
    func deleteAllMovies() {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        print("Realmのデータを削除しました")
    }
    //MARK: - Tableview設定
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realm = try! Realm()
        let videoItems = realm.objects(VideoItem.self)
        
        return videoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MovieCell
        
        let realm = try! Realm()
        let videoItems = realm.objects(VideoItem.self)
        
        cell.titleLabel.text = videoItems[indexPath.row].title
        cell.nameLabel.text = videoItems[indexPath.row].name
        cell.idLabel.text = videoItems[indexPath.row].id
        
        //サムネイル表示
        if let url = URL(string: videoItems[indexPath.row].image) {
            downloadImage(from: url) { image in
                DispatchQueue.main.async {
                    cell.image.image = image
                }
            }
        }
        return cell
    }
    // タップ時の処理
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Movie \(indexPath.row) tapped")
    }
    
    //MARK: - Helper
    // 画像ダウンロード
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error downloading image: \(String(describing: error))")
                completion(nil)
                return
            }
            // イメージを返す
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
    }
    
    
    @objc func backButtonTapped() {
     //login画面に戻る
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                let loginController = LoginController()
                loginController.isLogout = true
                window.rootViewController = loginController
                window.makeKeyAndVisible()
            }
        }
        
    }
}
