//
//  User.swift
//  GithubFollowers
//
//  Created by 임현지 on 2021/04/18.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl : String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var following: Int
    var followers: Int
    var createdAt: String
}
