import Foundation
import RealmSwift


class VideoRepository {
    
    private let apiURL = "https://live.fc2.com/contents/allchannellist.php"
    // 動画データ取得とRealmへの保存
    func fetchFromAPI(completion: @escaping ([VideoItem]) -> Void) {
        guard let url = URL(string: apiURL) else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error occurred: \(error)")
                completion([])
                return
            }
            
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonDict = json as? [String: Any],
                   let contents = jsonDict["channel"] as? [[String: Any]] {
                    let videoItems = contents.map { content -> VideoItem in
                        let videoItem = VideoItem()
                        videoItem.title = content["title"] as? String ?? ""
                        videoItem.name = content["name"] as? String ?? ""
                        videoItem.id = content["id"] as? String ?? ""
                        videoItem.image = content["image"] as? String ?? ""
                        return videoItem
                    }
                    // Realmに保存
                    self.saveVideos(videoItems)
                    completion(videoItems)
                } else {
                    completion([])
                }
            } catch {
                print("Failed to parse JSON: \(error)")
                completion([])
            }
        }.resume()
    }
    // ローカルDBから取得
    func fetchFromLocalDB() -> [VideoItem] {
        let realm = try! Realm()
        let videos = Array(realm.objects(VideoItem.self))
        return videos
    }
    
    // ローカルDB保存
    func saveVideos(_ videos: [VideoItem]) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(videos)
        }
    }
    
    
}
