import XCTest
@testable import SimpleVideoListApp

class UserDefaultsRepositoryTests: XCTestCase {
    var userDefaultsRepository: UserDefaultsRepository!
    
    override func setUp() {
        super.setUp()
        UserDefaults.standard.removeObject(forKey: "hasVisitedBefore")
        UserDefaults.standard.removeObject(forKey: "lastLoginTime")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
        
        userDefaultsRepository = UserDefaultsRepository()
    }

    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: "hasVisitedBefore")
        UserDefaults.standard.removeObject(forKey: "lastLoginTime")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "password")
        super.tearDown()
    }

    //  初回起動フラグテスト
    func testGetHasVisitedBefore() {
        XCTAssertFalse(userDefaultsRepository.getHasVisitedBefore())
        userDefaultsRepository.setHasVisitedBefore()
        XCTAssertTrue(userDefaultsRepository.getHasVisitedBefore())
    }

    // ログイン時間取得・保存テスト
    func testSetAndGetLastLoginTime() {
        let currentTime = Date().timeIntervalSince1970
        userDefaultsRepository.setLastLoginTime(currentTime)
        XCTAssertEqual(userDefaultsRepository.getLastLoginTime()!, currentTime, accuracy: 1.0, "ログイン時間が一致しません")
    }

    // ユーザー情報取得テスト
    func testGetUserInfo() {
        let email = "test@example.com" // for test
        let password = "123"   // for test
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.set(password, forKey: "password")
        
        let userInfo = userDefaultsRepository.getUserInfo()
        XCTAssertEqual(userInfo["email"] ?? "", email, "Emailが一致しません")
        XCTAssertEqual(userInfo["password"] ?? "", password, "Passwordが一致しません")
    }
    
    // ユーザー情報保存テスト
    func testSetUserInfo() {
        let email = "test@example.com"
        let password = "123"
        userDefaultsRepository.setUserInfo(email: email, password: password)
        
        let getEmail = UserDefaults.standard.string(forKey: "email") ?? ""
        let getPassword = UserDefaults.standard.string(forKey: "password") ?? ""
        XCTAssertEqual(getEmail, email, "Emailが一致しません")
        XCTAssertEqual(getPassword, password, "Passwordが一致しません")
    }
}
