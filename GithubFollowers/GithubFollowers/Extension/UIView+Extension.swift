//
//  UIView+Extension.swift
//  GithubFollowers
//
//  Created by 임현지 on 2021/05/11.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
