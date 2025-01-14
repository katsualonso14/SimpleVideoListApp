import XCTest
@testable import SimpleVideoListApp

class APIRepositoryTests: XCTestCase {

    var apiRepository: APIRepository!

    override func setUp() {
        super.setUp()
        apiRepository = APIRepository()
    }

    override func tearDown() {
        apiRepository = nil
        super.tearDown()
    }

    // APIデータ取得
    func testFetchFromAPI() {
        let expectation = XCTestExpectation(description: "Fetching data from API")
        apiRepository.fetchFromAPI { videoItems in
            XCTAssertNotNil(videoItems) // 所得したデータがnilでないことを確認
            XCTAssertGreaterThan(videoItems.count, 0) // 所得したデータが1件以上であることを確認
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

}
