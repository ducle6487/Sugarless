//
//  CustomAllProduct.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 29/12/2020.
//

import UIKit

class CustomAllProductCollectionView: UIView, UICollectionViewDelegateFlowLayout{
    
    //dùng biến để chúa các dữ liệu cần load
    
    var listMonAn = [MonAn]()
    
    var prevVC : UIViewController?
    
    
    
    var cellID = "AllProductCellID"
    let screenWidth = UIScreen.main.bounds.width
    
    
    
    lazy var collectionView : UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        
        let clv = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        
        clv.contentInset.top = 20
        clv.showsVerticalScrollIndicator = false
        
        clv.delegate = self
        clv.dataSource = self
        clv.backgroundColor = .init(white: 1, alpha: 0)
        return clv
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(CustomMainPageCellCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalToSuperview().offset(screenWidth / 21)
            make.trailing.equalToSuperview().offset(-(screenWidth / 21))
        }
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomAllProductCollectionView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listMonAn.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CustomMainPageCellCollectionViewCell
        
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 0.75
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.productImg.image = nil
        cell.setupView(image: listMonAn[indexPath.item].id ?? "", name: listMonAn[indexPath.item].name ?? "", price: listMonAn[indexPath.item].price ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth * (3/7), height: collectionView.frame.height / 3.1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = DetailProductViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.name = listMonAn[indexPath.item].name ?? ""
        vc.image = listMonAn[indexPath.item].id ?? ""
        vc.des = listMonAn[indexPath.item].description ?? ""
        vc.price = listMonAn[indexPath.item].price ?? ""
        prevVC?.present(vc, animated: true, completion: nil)
    }
    
    
}
