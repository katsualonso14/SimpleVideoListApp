import Combine
import Foundation

//AppRepositoryからViewに
class AppViewModel {
    private let appRepository = AppRepository()
    private let videoRepository = VideoRepository()
//    private var cancellables = Set<AnyCancellable>()
    // データ取得方法
    @Published var dataSource: String = ""
    
    //TODO: この処理がいるか検討
//    func checkLoginOrVideoList() -> String {
//        if (checkFirstLaunch() == true) {
//            return "VideoList"
//        } else {
//            return "Login"
//        }
//    }
    
    // 初回起動チェック
    func checkFirstLaunch() -> Bool {
        if (appRepository.hasVisitedBefore == false) {
            appRepository.setHasVisitedBefore()
            return false
        } else {
            return true
        }
    }
    
    // 最後のログイン時間確認
    func checkLoginTime() -> Bool {
        guard let lastLoginTime = appRepository.getLastLoginTime() else {
            return false
        }
        
        let currentTime = Date().timeIntervalSince1970
        return (currentTime - lastLoginTime) <= 300
    }
    
    func getData(completion: @escaping ([VideoItem]) -> Void) {
        // 初回起動確認
        if appRepository.hasVisitedBefore {
            handleSecondLaunch(completion: completion)
        } else {
            handleFirstLaunch(completion: completion)
        }
    }

    private func handleSecondLaunch(completion: @escaping ([VideoItem]) -> Void) {
        //最終ログイン時間チェック
        if checkLoginTime() {
            completion(videoRepository.fetchFromLocalDB())
        } else {
            videoRepository.fetchFromAPI { items in
                completion(items)
            }
        }
    }

    private func handleFirstLaunch(completion: @escaping ([VideoItem]) -> Void) {
        videoRepository.fetchFromAPI { items in
            completion(items)
        }
    }

    
}
