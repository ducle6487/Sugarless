//
//  MainPageCollectionView.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 28/12/2020.
//

import UIKit

class MainPageCollectionView: UIView, UICollectionViewDelegateFlowLayout{
    
    
    private let mainCellID = "mainCell"
    var mainPageVC: MainPageViewController?
    
    
    var layout : UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        return layout
    }()
    
    lazy var collectionView : UICollectionView = {
        
        let clv = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        
        clv.delegate = self
        clv.dataSource = self
        clv.backgroundColor = .init(white: 1, alpha: 0)
        return clv
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        collectionView.register(MainPageCollectionViewCell.self, forCellWithReuseIdentifier: mainCellID)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension MainPageCollectionView :  UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: mainCellID, for: indexPath) as! MainPageCollectionViewCell
        
        cell.MainPage = mainPageVC
        
        if indexPath.item == 2{
            cell.setupViewsLarge()
        }else if indexPath.item == 0{
            cell.setupViewBestSeller()
        }else{
            cell.setupViewFavourite()
        }
        return cell
        
    }
    
    
    
    
    
    
}
