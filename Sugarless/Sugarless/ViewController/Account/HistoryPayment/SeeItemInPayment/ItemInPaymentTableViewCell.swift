//
//  ItemInPaymentTableViewCell.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 22/01/2021.
//

import UIKit
import FirebaseStorage

class ItemInPaymentTableViewCell: UITableViewCell {
    
    let storage = Storage.storage()
    
    let screenWidth = UIScreen.main.bounds.width
    
    var coverNameVw = UIView()
    var coverButtonVw = UIView()
    
    var productImg = UIImageView()
    var nameLb = UILabel()
    var priceLb = UILabel()
    
    var amountLb = UILabel()
    
    func setupView(name: String, image: String, amount: Int, price: String){
        
        contentView.addSubview(productImg)
        productImg.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview().inset(screenWidth / 20)
            make.width.equalToSuperview().dividedBy(5)
        }
        
        
        let storageRef = storage.reference()
        let starsRef = storageRef.child("Product/\(image).jpg")
        
        starsRef.downloadURL { [self] url, error in
          if let error = error {
            print(error)
          } else {
            
            productImg.downloaded(from: url!)
            productImg.contentMode = .scaleAspectFit
            
          }
        }
        
        
        contentView.addSubview(coverNameVw)
        coverNameVw.snp.makeConstraints { (make) in
            make.top.equalTo(productImg)
            make.bottom.equalTo(contentView.snp.centerY)
            make.leading.equalTo(productImg.snp.trailing).offset(screenWidth  / 20)
            make.width.equalToSuperview().dividedBy(1.8)
        }
        
        
        
        coverNameVw.addSubview(nameLb)
        nameLb.snp.makeConstraints { (make) in
            make.leading.trailing.lessThanOrEqualToSuperview()
            make.top.bottom.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        nameLb.numberOfLines = 2
        nameLb.adjustsFontSizeToFitWidth = true
        nameLb.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        nameLb.text = name
        
        
        contentView.addSubview(priceLb)
        priceLb.snp.makeConstraints { (make) in
            make.top.equalTo(productImg.snp.centerY)
            make.bottom.equalTo(productImg)
            make.trailing.equalToSuperview().offset(-(screenWidth / 20))
            make.width.equalToSuperview().dividedBy(3)
        }
        
        
        priceLb.text = Int(price)!.formattedWithSeparator + "VNĐ"
        priceLb.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        priceLb.textAlignment = .right
        priceLb.adjustsFontSizeToFitWidth = true
        priceLb.textColor = .systemRed
        
        
        contentView.addSubview(coverButtonVw)
        coverButtonVw.snp.makeConstraints { (make) in
            make.leading.equalTo(coverNameVw)
            make.top.equalTo(productImg.snp.centerY).offset(screenWidth / 20)
            make.bottom.equalTo(productImg)
            make.trailing.equalTo(priceLb.snp.leading)
        }
        
        
        coverButtonVw.addSubview(amountLb)
        amountLb.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.width.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        amountLb.textAlignment = .center
        amountLb.text = "Số lượng: \(amount)"
        amountLb.font = .systemFont(ofSize: 18)
        
        
        
        
        
        
    }
    
}
