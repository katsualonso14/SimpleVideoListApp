
import Foundation
import RealmSwift

class LocalDBRepository {
    // ローカルDBから取得
    func fetchFromLocalDB() -> [VideoItem] {
        let realm = try! Realm()
        let videos = Array(realm.objects(VideoItem.self))
        return videos
    }
    
    // ローカルDB保存
    func saveVideos(_ videos: [VideoItem]) {
        DispatchQueue.global(qos: .background).async {
            let realm = try! Realm()
            try! realm.write {
                realm.add(videos)
            }
        }
    }
}
