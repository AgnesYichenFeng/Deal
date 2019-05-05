//
//  ViewController.swift
//  Deal
//
//  Created by Nina Xie on 4/25/19.
//  Copyright © 2019 F(X). All rights reserved.
//

import UIKit

//protocol postNewItem: class {
//    func addNewItem(newItem: Item)
//}

class DealViewController: UIViewController {
    
    var refresh : UIRefreshControl!
    var searchBar: UISearchBar!
    var itemCollectionView: UICollectionView!
    
    var items: [Item] = []
    var searchedItems: [Item] = []
    var searchActive : Bool = false
    
//    var main = TabBarController!
    
    let defaults = UserDefaults.standard
    
    let padding: CGFloat = 18
    let itemCellReuseIdentifier = "itemCellReuseIdentifier"
    let lightGrey = UIColor(named: "LightGrey")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.title = "Deal"
        view.backgroundColor = lightGrey
       
       // items = DealAPI.getItems()  // for testing
        searchedItems = items
        
        // refreshControl
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(pulledToRefresh), for: .valueChanged)
        
        // searchBar
        searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search for items"
        searchBar.backgroundImage = UIImage()
        
        searchBar.layer.shadowColor = UIColor.lightGray.cgColor
        searchBar.layer.shadowOffset = CGSize(width: 2.5,height: 2.5)
        searchBar.layer.shadowRadius = 5
        searchBar.layer.shadowOpacity = 0.8
        searchBar.delegate = self
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = .white
        textFieldInsideSearchBar?.textColor = .gray
        view.addSubview(searchBar)
        
        // itemCollectionView
        let itemCollectionViewFlowLayout = UICollectionViewFlowLayout()
        itemCollectionViewFlowLayout.scrollDirection = .vertical
        itemCollectionViewFlowLayout.minimumInteritemSpacing = padding
        itemCollectionViewFlowLayout.minimumLineSpacing = padding
        itemCollectionViewFlowLayout.itemSize = CGSize(width: (view.frame.width-3*padding)/2, height: (view.frame.width-3*padding)/2+96)
        itemCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        itemCollectionView = UICollectionView(frame: .zero, collectionViewLayout: itemCollectionViewFlowLayout)
        itemCollectionView.translatesAutoresizingMaskIntoConstraints = false
        itemCollectionView.backgroundColor = .clear
        itemCollectionView.alwaysBounceVertical = true
        itemCollectionView.delegate = self
        itemCollectionView.dataSource = self
        itemCollectionView.refreshControl = refresh
        itemCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: itemCellReuseIdentifier)
        view.addSubview(itemCollectionView)
        
        setupConstraints()
        
//        let PostVC = PostViewController()
//        PostVC.delegate = self
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            searchBar.widthAnchor.constraint(equalToConstant: 388)
            ])
        
        NSLayoutConstraint.activate([
            itemCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0),
            itemCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            itemCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            itemCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            ])
    }
    
    @objc func pulledToRefresh() {
//        main = TabBarController()
//        main.updateTime()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refresh.endRefreshing()
        }
    }
    
}

extension DealViewController:  UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return searchedItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellReuseIdentifier, for: indexPath) as! ItemCollectionViewCell
        
        let item = searchedItems[indexPath.item]
        itemCell.configure(for: item)
    
        itemCell.layer.cornerRadius = 8
        itemCell.layer.backgroundColor = UIColor.white.cgColor
        itemCell.layer.shadowColor = UIColor.lightGray.cgColor
        itemCell.layer.shadowOffset = CGSize(width: 2.5,height: 2.5)
        itemCell.layer.shadowRadius = 5
        itemCell.layer.shadowOpacity = 0.8
        
        return itemCell
        
    }
    
}

extension DealViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemSelected = searchedItems[indexPath.item]
        let indexSelected = indexPath
        
        let itemDetailView = ItemDetailNavgationViewController(item: itemSelected, index: indexSelected)
        navigationController?.pushViewController(itemDetailView, animated: true)
        
    }
}

extension DealViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        searchBar.endEditing(true)
        searchBar.showsCancelButton = false
        searchedItems = items
        itemCollectionView.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText == "") {
            searchedItems = items
        }else {
            getSearchedItems(items: items, searchText: searchText)
        }
        itemCollectionView.reloadData()
    }

    func getSearchedItems(items : [Item], searchText: String) {
        searchedItems = []
        for item in items {
            if(item.itemName.lowercased().contains(searchText.lowercased()) || item.descriptionText.lowercased().contains(searchText.lowercased())) {
                searchedItems.append(item)
            }
        }
    }
    
    
    func getAllPosts() {
        NetworkManager.getAllPosts { (allPosts) in
            self.items = allPosts
            DispatchQueue.main.async {
                self.itemCollectionView.reloadData()
            }
            
        }
    }

}

//extension DealViewController: postNewItem {
//
//    func addNewItem(newItem: Item) {
//        print ("Data received")
//
//        items.append(newItem)
//        itemCollectionView.reloadData()
//    }
//}
