import Foundation

// 動画取得、保存用Model
class LocalDBRepository {
    private let realmService: RealmDatabaseService
    
    init(realmService: RealmDatabaseService = RealmDatabaseService()) {
        self.realmService = realmService
    }
    
    // 動画取得
    func fetchVideos() throws -> [VideoItem] {
        let realmService = RealmDatabaseService()
        return try realmService.fetchVideoItems()
    }
    
    // 動画保存
    func saveVideos(_ videos: [VideoItem], completion: @escaping (Error?) -> Void) {
           realmService.saveVideos(videos) { error in
               completion(error)
           }
       }
}
