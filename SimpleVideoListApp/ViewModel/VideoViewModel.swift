import Foundation

class VideoViewModel {
    private let userDefaultsRepository = UserDefaultsRepository()
    private let apiRepository = APIRepository()
    private let localDBRepository = LocalDBRepository()
    private let loginCheckViewModel = LoginCheckViewModel()
    
    func getData(completion: @escaping ([VideoItem]) -> Void) {
        // 初回起動確認
        if userDefaultsRepository.getHasVisitedBefore() {
            handleSecondLaunch(completion: completion)
        } else {
            handleFirstLaunch(completion: completion)
        }
    }

    private func handleSecondLaunch(completion: @escaping ([VideoItem]) -> Void) {
        // 最終ログイン時間チェック
        if loginCheckViewModel.checkLoginTime() {
            do {
                let videos = try localDBRepository.fetchVideos()
                completion(videos)
            } catch {
                print("Error fetching videos from local DB: \(error)")
                completion([])
            }
        } else {
            apiRepository.fetchFromAPI { items in
                completion(items)
                DispatchQueue.global().async {
                    self.localDBRepository.saveVideos(items) { error in
                        if let error = error {
                            print("Error saving videos to local DB: \(error)")
                        }
                    }
                }
            }
        }
    }

    private func handleFirstLaunch(completion: @escaping ([VideoItem]) -> Void) {
        apiRepository.fetchFromAPI { items in
            DispatchQueue.global().async {
                self.localDBRepository.saveVideos(items) { error in
                    if let error = error {
                        print("Error saving videos to local DB: \(error)")
                        DispatchQueue.main.async {
                            completion([])
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(items)
                        }
                    }
                }
            }
        }
    }


}
