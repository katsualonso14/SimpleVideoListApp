import Foundation

class UserDefaultsRepository {
    // 初回起動フラグ
    func getHasVisitedBefore() -> Bool {
        return UserDefaults.standard.bool(forKey: "hasVisitedBefore")
    }
    //初期起動フラグを保存
    func setHasVisitedBefore() {
        UserDefaults.standard.set(true, forKey: "hasVisitedBefore")
    }
        
    // ログイン時間を取得
    func getLastLoginTime() -> TimeInterval? {
        return UserDefaults.standard.value(forKey: "lastLoginTime") as? TimeInterval
    }
    
    // ログイン時間を保存
    func setLastLoginTime(_ time: TimeInterval) {
        UserDefaults.standard.set(time, forKey: "lastLoginTime")
    }
    
    // ユーザー情報を取得
    func getUserInfo() -> [String: String?] {
        return [
            "email": UserDefaults.standard.string(forKey: "email"),
            "password": UserDefaults.standard.string(forKey: "password")
        ]
    }
    
    // ユーザー情報を保存
    func setUserInfo(email: String, password: String) {
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
    }
}
