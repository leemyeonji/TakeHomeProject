//
//  UIViewController+Extension.swift
//  GithubFollowers
//
//  Created by 임현지 on 2021/04/18.
//

import Foundation
import UIKit

extension UIViewController {
    // ui element니까
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
