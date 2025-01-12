import Foundation

class AppViewModel {
    private let userDefaultsRepository = UserDefaultsRepository()
    
    // 初回起動チェック
    func checkVisitedBefore() -> Bool {
        return userDefaultsRepository.getHasVisitedBefore()
    }
    // 初回起動フラグセット
    func setVisitedBefore() {
        userDefaultsRepository.setHasVisitedBefore()
    }
    // Email, Passwordセット
    func setUserInfo() -> [String: String?] {
        return userDefaultsRepository.setUserInfo()
    }
    
}
