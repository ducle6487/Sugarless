//
//  FavouriteCollectionView.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 28/12/2020.
//

import UIKit

class FavouriteCollectionView : CustomProductCellCollectionView{
    
    private let besSellerCellID = "bestSellCell"
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: besSellerCellID, for: indexPath) as! CustomProductCellCollectionViewCell
        
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 0.75
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.setupView()
        
        return cell
    }
    
}
