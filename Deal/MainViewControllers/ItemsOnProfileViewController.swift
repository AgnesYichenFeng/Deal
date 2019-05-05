//
//  ItemsOnProfileViewController.swift
//  Deal
//
//  Created by Nina Xie on 4/26/19.
//  Copyright © 2019 F(X). All rights reserved.
//

import UIKit

class ItemsOnProfileViewController: UIViewController {

    
    var itemsCollectionView: UICollectionView!
    
    var items: [Item]
    let itemOnProfileCellReuseIdentifier = "itemOnProfileCellReuseIdentifier"
    let padding: CGFloat = 18
    
    
    init(items: [Item]) {
    self.items = items
    super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
//        items = [DealAPI.getItems()[0], DealAPI.getItems()[2]] // for testing
        
        let itemsCollectionViewFlowLayout = UICollectionViewFlowLayout()
        itemsCollectionViewFlowLayout.scrollDirection = .vertical
        itemsCollectionViewFlowLayout.minimumInteritemSpacing = padding
        itemsCollectionViewFlowLayout.minimumLineSpacing = padding
        
        itemsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: itemsCollectionViewFlowLayout)
        itemsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        itemsCollectionView.backgroundColor = .clear
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
        itemsCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: itemOnProfileCellReuseIdentifier)
        view.addSubview(itemsCollectionView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            itemsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            itemsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -1*padding),
            itemsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -1*padding)
            ])
    }
    
    
}


extension ItemsOnProfileViewController:  UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: itemOnProfileCellReuseIdentifier, for: indexPath) as! ItemCollectionViewCell
        let item = items[indexPath.item]
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

extension ItemsOnProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemSelected = items[indexPath.item]
        
        let itemDetailView = ItemDetailNavgationViewController(item: itemSelected, index: indexPath)
        navigationController?.pushViewController(itemDetailView, animated: true)
    }
}

extension ItemsOnProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - padding)/2
        return CGSize(width: width, height: width+96)
    }
}

