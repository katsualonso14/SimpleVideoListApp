import XCTest
@testable import SimpleVideoListApp

// モックを間に挟む
class MockRealmDatabaseService: RealmDatabaseService {
    var mockVideos: [VideoItem] = []
    
    override func fetchVideoItems() throws -> [VideoItem] {
        return mockVideos
    }
    
    override func saveVideos(_ videos: [VideoItem], completion: @escaping (Error?) -> Void) {
        mockVideos.append(contentsOf: videos)
        completion(nil)
    }
}

class LocalDBRepositoryTests: XCTestCase {
    var localDBRepository: LocalDBRepository!
    var mockRealmService: MockRealmDatabaseService!
    
    override func setUp() {
        super.setUp()
        mockRealmService = MockRealmDatabaseService()
        localDBRepository = LocalDBRepository(realmService: mockRealmService)
    }
    
    override func tearDown() {
        localDBRepository = nil
        mockRealmService = nil
        super.tearDown()
    }
    // 動画取得
    func testFetchVideos() {
        mockRealmService.mockVideos = [VideoItem(value: ["title": "Sample", "id": "1"])]
        
        do {
            let videoItems = try localDBRepository.fetchVideos()
            XCTAssertNotNil(videoItems) //取得したデータがnilでないことを確認
            XCTAssertGreaterThan(videoItems.count, 0) //取得したデータが1件以上であることを確認
        } catch {
            XCTFail("Fetching videos failed: \(error)")
        }
    }
    
    // 動画保存
    func testSaveVideos() {
        let video = VideoItem(value: ["title": "Sample", "name": "Sample", "id": "Sample", "image": "Sample"])
        
        let expectation = self.expectation(description: "Save video completes")
        
        localDBRepository.saveVideos([video]) { error in
            XCTAssertNil(error) // エラーがnilであることを確認
            XCTAssertEqual(self.mockRealmService.mockVideos.count, 1) // 保存された動画が存在することを確認
            XCTAssertEqual(self.mockRealmService.mockVideos[0].title, "Sample") // 保存データ確認
            XCTAssertEqual(self.mockRealmService.mockVideos[0].name, "Sample")
            XCTAssertEqual(self.mockRealmService.mockVideos[0].id, "Sample")
            XCTAssertEqual(self.mockRealmService.mockVideos[0].image, "Sample")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
