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
        //最終ログイン時間チェック
        if loginCheckViewModel.checkLoginTime() {
            completion(localDBRepository.fetchFromLocalDB())
        } else {
            apiRepository.fetchFromAPI { items in
                completion(items)
                self.localDBRepository.saveVideos(items)// ローカルDBに保存
            }
        }
    }

    private func handleFirstLaunch(completion: @escaping ([VideoItem]) -> Void) {
        apiRepository.fetchFromAPI { items in
            self.localDBRepository.saveVideos(items)// ローカルDBに保存
            completion(items)
        }
    }

}
