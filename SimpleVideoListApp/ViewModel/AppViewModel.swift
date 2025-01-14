import Foundation

class AppViewModel {
    private let userDefaultsRepository = UserDefaultsRepository()
    // 初回起動チェック
    func checkVisitedBefore() -> Bool {
        return userDefaultsRepository.getHasVisitedBefore()
    }
    // 初回起動フラグ保存
    func setVisitedBefore() {
        userDefaultsRepository.setHasVisitedBefore()
    }
    // Email,Password取得
    func getUserInfo() -> [String: String?] {
        return userDefaultsRepository.getUserInfo()
    }
    // Email,Password保存
    func setUserInfo(email: String, password: String) {
        userDefaultsRepository.setUserInfo(email: email, password: password)
    }
    
}
