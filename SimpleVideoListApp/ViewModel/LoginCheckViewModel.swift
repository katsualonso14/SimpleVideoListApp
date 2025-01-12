import Foundation

class LoginCheckViewModel {
    private let userDefaultsRepository = UserDefaultsRepository()
    
    //　最後のログイン時間保存
    func setLoginTime() {
        let currentTime = Date().timeIntervalSince1970
        userDefaultsRepository.setLastLoginTime(currentTime)
    }
    
    // 最後のログイン時間確認
    func checkLoginTime() -> Bool {
        guard let lastLoginTime = userDefaultsRepository.getLastLoginTime() else {
            return false
        }
        
        let currentTime = Date().timeIntervalSince1970
        let elapsedTime = currentTime - lastLoginTime
        return elapsedTime <= 300
    }
}

