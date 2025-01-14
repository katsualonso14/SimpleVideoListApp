import Foundation

class APIRepository {
    
    private let apiURL = "https://live.fc2.com/contents/allchannellist.php"
    
    func fetchFromAPI(completion: @escaping ([VideoItem]) -> Void) {
        guard let url = URL(string: apiURL) else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error occurred: \(error)")
                completion([])
                return
            }
            
            guard let data = data else {
                completion([])
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let jsonDict = json as? [String: Any],
                   let contents = jsonDict["channel"] as? [[String: Any]] {
                    let videoItems = contents.map { content -> VideoItem in
                        let videoItem = VideoItem()
                        videoItem.title = content["title"] as? String ?? ""
                        videoItem.name = content["name"] as? String ?? ""
                        videoItem.id = content["id"] as? String ?? ""
                        videoItem.image = content["image"] as? String ?? ""
                        return videoItem
                    }
                    completion(videoItems)
                } else {
                    completion([])
                }
            } catch {
                print("Failed to parse JSON: \(error)")
                completion([])
            }
        }.resume()
    }
    
}
