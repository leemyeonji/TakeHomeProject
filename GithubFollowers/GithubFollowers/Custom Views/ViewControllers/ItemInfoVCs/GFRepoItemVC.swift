//
//  GFRepoItemVC.swift
//  GithubFollowers
//
//  Created by 임현지 on 2021/04/29.
//

import UIKit

class GFRepoItemVC : GFItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewTwo.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewOne.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
        
    }
}
