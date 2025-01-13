import RealmSwift

class RealmDatabaseService {
    private let realm: Realm
    
    init() {
        do {
            self.realm = try Realm()
        } catch {
            fatalError("Could not initialize Realm: \(error.localizedDescription)")
        }
    }
    
    // 動画取得
    func fetchVideoItems() throws -> [VideoItem] {
        let results = realm.objects(VideoItem.self)
        return Array(results)
    }
    
    // 動画保存
    func saveVideos(_ videos: [VideoItem], completion: @escaping (Error?) -> Void) {
        DispatchQueue.main.async {
            do {
                try self.realm.write {
                    self.realm.add(videos, update: .modified)
                }
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }

    
}
