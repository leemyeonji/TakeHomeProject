//
//  ErrorMessage.swift
//  GithubFollowers
//
//  Created by 임현지 on 2021/04/19.
//

import Foundation

enum GFError: String, Error {
    case invalidUsername = "User name 이 확인이 안되어요. 다시 시도해 주세요"
    case unableToComplete = "네트워크 요청 실패에요🥲.. 인터넷 연결을 확인해 보세요."
    case invalidResponse = "응답이 오지 않네요... 다시 시도해 보세요 😢."
    case invalidData = "서버로 보낸 데이터에 문제가 있나봐요. 다시 시도해 주세요 😭."
    case unableToFavorite = "젤로 좋아하는 유저 불러오기를 실패했어요. 다시 시도해 주세요 🥲. "
    case alreadyInFavorites = "이미 젤로 좋아하시는 유저에요 😀."
}
