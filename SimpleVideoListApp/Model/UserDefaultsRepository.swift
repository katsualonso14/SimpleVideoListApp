
import Foundation

class UserDefaultsRepository {
    // 初回起動フラグ
    func getHasVisitedBefore() -> Bool {
        return UserDefaults.standard.bool(forKey: "hasVisitedBefore")
    }
    //初期起動フラグをセット
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
    
    // ユーザー情報セット
    func setUserInfo() -> [String: String?] {
        return [
            "email": UserDefaults.standard.string(forKey: "email"),
            "password": UserDefaults.standard.string(forKey: "password")
        ]
    }
    
}
