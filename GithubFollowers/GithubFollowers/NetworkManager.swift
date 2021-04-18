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
    //data 를 [Followers], 에러를 그냥 옵셔널 string으로
    func getFollowers(for username: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void?) {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        // error handling !
        guard let url = URL(string: endpoint) else {
            completed(nil, "User name 이 확인이 안되어요. 다시 시도해 주세요")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(nil, "네트워크 요청 실패에요🥲.. 인터넷 연결을 확인해 보세요.")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "응답이 오지 않네요... 다시 시도해 보세요. 😢")
                return
            }
            guard let data = data else {
                completed(nil, "서버로 보낸 데이터에 문제가 있나봐요. 다시 시도해 주세요. 😭")
                return
            }
            // 후 ! 드디어 받은 데이터를 파싱
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try? decoder.decode([Follower].self, from: data)
                completed(followers, nil)
            } catch {
                completed(nil, "서버로 보낸 데이터에 문제가 있나봐요. 다시 시도해 주세요. 😭")
            }
        }
        task.resume()
    }
}
