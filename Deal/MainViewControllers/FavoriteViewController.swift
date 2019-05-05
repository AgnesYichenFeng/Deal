//
//  FavoriteViewController.swift
//  Deal
//
//  Created by 谢静怡 on 4/26/19.
//  Copyright © 2019 Nina Xie. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    var favoriteCollectionView: UICollectionView!
    
    var favoriteItems: [Item] = []
    let favoriteCellReuseIdentifier = "favoriteCellReuseIdentifier"
    let padding: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.title = "My Favorites"
        view.backgroundColor = .white
        
        favoriteItems = [DealAPI.getItems()[0], DealAPI.getItems()[2]] // for testing
        
        let favoriteCollectionViewFlowLayout = UICollectionViewFlowLayout()
        favoriteCollectionViewFlowLayout.scrollDirection = .vertical
        favoriteCollectionViewFlowLayout.minimumInteritemSpacing = padding
        favoriteCollectionViewFlowLayout.minimumLineSpacing = padding
        
        favoriteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: favoriteCollectionViewFlowLayout)
        favoriteCollectionView.translatesAutoresizingMaskIntoConstraints = false
        favoriteCollectionView.backgroundColor = .clear
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: favoriteCellReuseIdentifier)
        view.addSubview(favoriteCollectionView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
       
        NSLayoutConstraint.activate([
            favoriteCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            favoriteCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            favoriteCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1*padding),
            favoriteCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -1*padding),
            ])
    }
    
    
}


extension FavoriteViewController:  UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favoriteItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: favoriteCellReuseIdentifier, for: indexPath) as! ItemCollectionViewCell
        let item = favoriteItems[indexPath.item]
        favoriteItemCell.configure(for: item)
        
        favoriteItemCell.layer.borderColor = UIColor.lightGray.cgColor
        favoriteItemCell.layer.borderWidth = 2
        favoriteItemCell.layer.cornerRadius = 12
        return favoriteItemCell
    }
    
}

extension FavoriteViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let favoriteItemSelected = favoriteItems[indexPath.item]
        
        let favoriteItemDealView = ItemDetailNavgationViewController(nameDetail: favoriteItemSelected.itemName, priceDetail: favoriteItemSelected.itemPrice, userDetail: favoriteItemSelected.userName, descriptionDetail: favoriteItemSelected.descriptionText, imageDetail: favoriteItemSelected.imageSet)
        navigationController?.pushViewController(favoriteItemDealView, animated: true)
    }
}

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - padding)/2
        return CGSize(width: width, height: width+80)
    }
}
