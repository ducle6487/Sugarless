//
//  TypeProductCollectionViewCell.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 08/01/2021.
//

import UIKit

class TypeProductCollectionViewCell: UICollectionViewCell {
    
    
    let imageView = UIImageView()
    let nameLb = UILabel()
    
    
    func setupView(id: String, name: String){
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview().dividedBy(1.5)
        }
        
        imageView.image = UIImage(named: id)
        imageView.contentMode = .scaleAspectFit
        
        contentView.addSubview(nameLb)
        nameLb.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom)
        }
        
        nameLb.textAlignment = .center
        nameLb.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        nameLb.numberOfLines = 2
        nameLb.text = name
        
    }
    
    
}
