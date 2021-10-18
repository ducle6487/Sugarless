//
//  BestSellerCollectionView.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 28/12/2020.
//

import UIKit

class CustomMainPageCellCollectionView: UIView, UICollectionViewDelegateFlowLayout{
    
    
    let besSellerCellID = "bestSellCell"
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        let clv = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        
        let leftInset: CGFloat = 20
        clv.contentInset.left = leftInset
        
        clv.showsHorizontalScrollIndicator = false
        clv.delegate = self
        clv.dataSource = self
        clv.backgroundColor = .init(white: 1, alpha: 0)
        return clv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
        collectionView.register(CustomMainPageCellCollectionViewCell.self, forCellWithReuseIdentifier: besSellerCellID)
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomMainPageCellCollectionView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: besSellerCellID, for: indexPath) as! CustomMainPageCellCollectionViewCell
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.25, height: collectionView.frame.height)
    }
    
    
    
}
