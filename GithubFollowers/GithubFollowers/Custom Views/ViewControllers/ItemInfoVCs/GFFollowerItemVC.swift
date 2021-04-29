//
//  GFFollowerItemVC.swift
//  GithubFollowers
//
//  Created by 임현지 on 2021/04/29.
//

import Foundation

class GFFollowerItemVC: GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColore: .systemGreen, title: "Get Followers")
    }
}
