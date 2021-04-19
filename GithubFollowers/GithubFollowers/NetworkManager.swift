//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by 임현지 on 2021/04/18.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    
    private init() {}
    // data 를 [Followers], 에러를 그냥 옵셔널 string으로
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, ErrorMessage?) -> Void) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        // error handling !
        guard let url = URL(string: endpoint) else {
            completed(nil, .invalidUsername)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(nil, .unableToComplete)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, .invalidResponse)
                return
            }
            guard let data = data else {
                completed(nil, .invalidData)
                return
            }
            // 후 ! 드디어 받은 데이터를 파싱
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try? decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, .invalidData)
            }
        }
        task.resume()
    }
}
