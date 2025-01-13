import Foundation
import UIKit

class ImageViewModel {
    // 画像取得
    func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error downloading image: \(String(describing: error))")
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }
        task.resume()
    }
    
}
