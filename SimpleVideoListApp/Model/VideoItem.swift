

import Foundation
import RealmSwift

class VideoItem: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var id: String = ""
//    @objc dynamic var image: Data? // サムネイル画像をData型で保存
    @objc dynamic var image: String = ""
}
