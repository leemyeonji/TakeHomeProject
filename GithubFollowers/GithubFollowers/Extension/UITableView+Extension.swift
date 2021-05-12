//
//  UITableView+Extension.swift
//  GithubFollowers
//
//  Created by 임현지 on 2021/05/12.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
