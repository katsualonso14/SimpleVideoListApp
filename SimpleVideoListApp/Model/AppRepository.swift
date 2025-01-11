
import Foundation

class AppRepository {
    // 初回起動フラグ
    var hasVisitedBefore: Bool {
        return UserDefaults.standard.bool(forKey: "hasVisitedBefore")
    }

    //初期起動フラグをセット
    func setHasVisitedBefore() {
        UserDefaults.standard.set(true, forKey: "hasVisitedBefore")
    }
    
    // ログイン時間をセット
    func getLastLoginTime() -> TimeInterval? {
        return UserDefaults.standard.value(forKey: "lastLoginTime") as? TimeInterval
    }
}
