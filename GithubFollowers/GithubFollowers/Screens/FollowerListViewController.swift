//
//  FollowerListViewController.swift
//  GithubFollowers
//
//  Created by 임현지 on 2021/04/18.
//

import UIKit

class FollowerListViewController: UIViewController {

    var username : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
