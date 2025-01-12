import Foundation

class AppViewModel {
    private let userDefaultsRepository = UserDefaultsRepository()
    private let apiRepository = APIRepository()
    private let localDBRepository = LocalDBRepository()
    
    // 初回起動チェック
    func checkVisitedBefore() -> Bool {
        return userDefaultsRepository.getHasVisitedBefore()
    }
    // 初回起動フラグセット
    func setVisitedBefore() {
        userDefaultsRepository.setHasVisitedBefore()
    }
    // 最後のログイン時間確認
    func checkLoginTime() -> Bool {
        guard let lastLoginTime = userDefaultsRepository.getLastLoginTime() else {
            return false
        }
        
        let currentTime = Date().timeIntervalSince1970
        let elapsedTime = currentTime - lastLoginTime
        print("checkLogin: \(elapsedTime <= 300)")
        return elapsedTime <= 300
    }
    
    //　最後のログイン時間保存ログイン
    func setLoginTime() {
        let currentTime = Date().timeIntervalSince1970
        userDefaultsRepository.setLastLoginTime(currentTime)
    }
    
    // Email, Passwordセット
    func setUserInfo() -> [String: String?] {
        return userDefaultsRepository.setUserInfo()
    }
    
    func getData(completion: @escaping ([VideoItem]) -> Void) {
        // 初回起動確認
        if userDefaultsRepository.getHasVisitedBefore() {
            handleSecondLaunch(completion: completion)
        } else {
            handleFirstLaunch(completion: completion)
        }
    }

    private func handleSecondLaunch(completion: @escaping ([VideoItem]) -> Void) {
        //最終ログイン時間チェック
        if checkLoginTime() {
            completion(localDBRepository.fetchFromLocalDB())
        } else {
            apiRepository.fetchFromAPI { items in
                completion(items)
                self.localDBRepository.saveVideos(items)// ローカルDBに保存
            }
        }
    }

    private func handleFirstLaunch(completion: @escaping ([VideoItem]) -> Void) {
        apiRepository.fetchFromAPI { items in
            self.localDBRepository.saveVideos(items)// ローカルDBに保存
            completion(items)
        }
    }

    
}
