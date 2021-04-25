//
//  UIViewController+Extension.swift
//  GithubFollowers
//
//  Created by 임현지 on 2021/04/18.
//

import Foundation
import UIKit

fileprivate var containerView: UIView!

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
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicater = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicater)
        
        activityIndicater.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicater.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicater.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicater.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
