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
    // Email,Password保存
    func setUserInfo() -> [String: String?] {
        return userDefaultsRepository.setUserInfo()
    }
    
}
