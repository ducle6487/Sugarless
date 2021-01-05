//
//  CustomAllProductCollectionViewCell.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 29/12/2020.
//

import UIKit

class CustomAllProductCollectionViewCell: UICollectionViewCell {
    
    let addBt = UIButton()
    
    var name: String?
    var price: String?
    
    func setupView(){
        
        let productImg = UIImageView()
        contentView.addSubview(productImg)
        productImg.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview().dividedBy(1.7)
        }
        productImg.image = UIImage(named: "test")
        productImg.contentMode = .scaleAspectFit
        
        let nameLb = UILabel()
        contentView.addSubview(nameLb)
        nameLb.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(contentView.frame.width / 15)
            make.trailing.equalToSuperview().offset(-(contentView.frame.width / 15))
            make.top.equalTo(productImg.snp.bottom).offset(contentView.frame.height / 25)
        }
        
        nameLb.text = name ?? "Lê Anh Đức"
        nameLb.numberOfLines = 2
        
        
        let priceLb = UILabel()
        contentView.addSubview(priceLb)
        priceLb.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLb)
            make.top.equalTo(nameLb.snp.bottom).offset(contentView.frame.height / 15)
            make.trailing.equalToSuperview().offset(-(contentView.frame.width * 0.3))
        }
        
        priceLb.text = price ?? "1000000"
        
        
        
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
