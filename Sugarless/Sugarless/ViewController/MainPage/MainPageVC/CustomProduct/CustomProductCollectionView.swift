//
//  BestSellerCollectionView.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 28/12/2020.
//

import UIKit

class CustomProductCollectionView: CustomMainPageCellCollectionView{
    
    
    //cho 1 bien chua data cho cả groceries, favourite , best seling
    
    var MainPage: MainPageViewController?
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: besSellerCellID, for: indexPath) as! CustomMainPageCellCollectionViewCell
        
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 0.75
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.setupView()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = DescriptionProductViewController()
        vc.modalPresentationStyle = .fullScreen
        MainPage?.present(vc, animated: true, completion: nil)
        
    }
    
    
}
