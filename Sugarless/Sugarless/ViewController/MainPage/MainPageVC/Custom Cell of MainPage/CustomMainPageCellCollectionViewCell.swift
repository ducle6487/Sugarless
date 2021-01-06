//
//  BestSellerCollectionViewCell.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 28/12/2020.
//

import UIKit

class CustomMainPageCellCollectionViewCell: UICollectionViewCell {
    
    let addBt = UIButton()
    let productImg = UIImageView()
    let nameLb = UILabel()
    let priceLb = UILabel()
    
    func setupView(image: String, name: String, price: String){
        
        
        
        contentView.addSubview(productImg)
        productImg.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview().dividedBy(1.7)
        }
        productImg.image = UIImage(named: image)
        productImg.contentMode = .scaleAspectFit
        
        
        contentView.addSubview(nameLb)
        nameLb.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(contentView.frame.width / 15)
            make.trailing.equalToSuperview().offset(-(contentView.frame.width / 15))
            make.top.equalTo(productImg.snp.bottom).offset(contentView.frame.height / 25)
        }
        
        nameLb.text = name
        nameLb.numberOfLines = 2
        
        
        
        contentView.addSubview(priceLb)
        priceLb.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLb)
            make.top.equalTo(nameLb.snp.bottom).offset(contentView.frame.height / 15)
            make.trailing.equalToSuperview().offset(-(contentView.frame.width * 0.3))
        }
        
        priceLb.text = "\(price) vnđ"
        
        
        
        contentView.addSubview(addBt)
        addBt.snp.makeConstraints { (make) in
            make.leading.equalTo(priceLb.snp.trailing)
            make.width.height.equalTo(contentView.frame.width * 0.25)
            make.top.equalTo(nameLb.snp.bottom).offset(contentView.frame.height / 40)
        }
        
        addBt.backgroundColor = .systemGreen
        addBt.setAttributedTitle(NSAttributedString(string: "+", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 35), NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        addBt.layer.cornerRadius = 17
        addBt.addTarget(self, action: #selector(addAct), for: .touchUpInside)
        
        
    }
    
    @objc func addAct(){
        
        UIView.animate(withDuration: 0.15,
            animations: {
                self.addBt.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.15) {
                    self.addBt.transform = CGAffineTransform.identity
                }
            })
        
        
    }
    
}
