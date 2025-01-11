import Foundation
import RealmSwift
import Combine

class ImageViewModel {
    
    // 画像の取得
    func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
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
    
    
    // データ取得
//    func loadVideos(hasVisitedBefore: Bool) {
//        let source = hasVisitedBefore ? "LocalDB" : "API"
//        repository.fetchVideos(from: source) { [weak self] videos in
//            DispatchQueue.main.async {
//                self?.videoItems = videos
//            }
//        }
//    }
    
    
//    // APIからデータ取得
//    func fetchAPIVideos() {
//        isLoading = true
//        let url = URL(string: "https://live.fc2.com/contents/allchannellist.php")!
//        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            DispatchQueue.main.async {
//                self?.isLoading = false
//                if let error = error {
//                    self?.errorMessage = "Error occurred: \(error.localizedDescription)"
//                    return
//                }
//                guard let data = data else {
//                    self?.errorMessage = "No data received"
//                    return
//                }
//                self?.parseAndSaveVideos(data: data)
//            }
//        }.resume()
//    }
//
//    // API取得データをローカルDBへ保存
//    private func parseAndSaveVideos(data: Data) {
//        do {
//            let json = try JSONSerialization.jsonObject(with: data, options: [])
//            if let json = json as? [String: Any],
//               let contents = json["channel"] as? [[String: Any]] {
//                let videoItems = contents.map { content -> VideoItem in
//                    let videoItem = VideoItem()
//                    videoItem.title = content["title"] as? String ?? ""
//                    videoItem.name = content["name"] as? String ?? ""
//                    videoItem.id = content["id"] as? String ?? ""
//                    videoItem.image = content["image"] as? String ?? ""
//                    return videoItem
//                }
//                VideoRepository.saveVideos(videoItems)
//                self.videoItems = videoItems
//            }
//        } catch {
//            self.errorMessage = "Failed to parse JSON: \(error.localizedDescription)"
//        }
//    }
}
