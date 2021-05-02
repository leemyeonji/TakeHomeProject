//
//  FollowerListViewController.swift
//  GithubFollowers
//
//  Created by 임현지 on 2021/04/18.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

class FollowerListViewController: UIViewController {

    enum Section { case main }
    
    var username : String!
    var followers: [Follower] = []
    var filteredFollwers: [Follower] = []
    var page: Int = 1
    var hasMoreFollower = true
    var isSearching = false
    
    var collectionView : UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers(userName: username, page: page)
        configureDataSource()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func getFollowers(userName: String, page: Int) {
        showLoadingView()
        // networkmanager 와 followerVC(self) 간의 참조에서 메모리 누수가 발생. weak 사용. weak 는 옵셔널임 
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollower = false }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them 🧞‍♂️"
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happend", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, followers) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as? FollowerCell
            cell?.set(follower: followers)
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapShot, animatingDifferences: true)
        }
    }
    
    @objc func addButtonTapped() {
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username){ [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(title: "Success!", message: "You hava seccessfully favorited this user!", buttonTitle: "OK")
                        return
                    }
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK..")
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}

extension FollowerListViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollower else { return }
            page += 1
            getFollowers(userName: username, page: page)
        }
    }
    
    // Item 탭 했을 때 -> userInfoVC로.. modal 로
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 복잡한 것이, 검색한 follower의 인덱스패스는 어떻게 할거냐 이말이야 그래서 flag 하나 세워뒀다 이말이야. isSearching
        let activeArray = isSearching ? filteredFollwers : followers
        let follower = activeArray[indexPath.item]
        
        let destVC = UserInfoViewController()
        destVC.username = follower.login
        destVC.delegate = self // FollowerListVC(Intern) is listening userInfoVC(Boss)
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension FollowerListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredFollwers = followers.filter{ $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filteredFollwers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
    
}

extension FollowerListViewController : FollowerListVCDelegate {
    // followerListVC 는 이 함수가 실행되길 기다린다... -> userInfoVC가 해줄거야
    
    func didRequestFollowers(for username: String) {
        // get followers for that user
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollwers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        
        getFollowers(userName: username, page: page)
    }
    
}
