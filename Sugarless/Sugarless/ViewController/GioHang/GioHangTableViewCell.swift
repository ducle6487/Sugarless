//
//  GioHangTableViewCell.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 10/01/2021.
//

import UIKit
import FirebaseStorage

class GioHangTableViewCell: UITableViewCell {

    // MARK: - Variable
    
    var gioHangVC : GioHangViewController?
    
    let storage = Storage.storage()
    
    let screenWidth = UIScreen.main.bounds.width
    
    var amountCount = 1
    var coverNameVw = UIView()
    var coverButtonVw = UIView()
    
    var productImg = UIImageView()
    var nameLb = UILabel()
    var priceLb = UILabel()
    
    var minusBt = UIButton()
    var amountLb = UILabel()
    var plusBt = UIButton()
    
    
    // MARK: -Setup View
    
    func setupView(name: String, image: String, amount: Int, price: String){
        
        amountCount = amount
        
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
            make.height.width.equalTo(contentView.frame.height).dividedBy(1.5)
            make.centerY.equalToSuperview()
        }
        
        amountLb.textAlignment = .center
        amountLb.text = "\(amountCount)"
        amountLb.font = .systemFont(ofSize: 20)
        
        
        
        coverButtonVw.addSubview(minusBt)
        minusBt.snp.makeConstraints { (make) in
            make.trailing.equalTo(amountLb.snp.leading).offset(-5)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(contentView.frame.height).dividedBy(1.5)
        }
        
        minusBt.titleLabel?.textAlignment = .center
        minusBt.layer.borderWidth = 0.5
        minusBt.layer.borderColor = UIColor.lightGray.cgColor
        minusBt.layer.cornerRadius = 15
        if amountCount <= 1{
            minusBt.setAttributedTitle(NSAttributedString(string: "-", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 60, weight: .light), NSAttributedString.Key.foregroundColor : UIColor.gray]), for: .normal)
        }else{
            minusBt.setAttributedTitle(NSAttributedString(string: "-", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 60, weight: .light), NSAttributedString.Key.foregroundColor : UIColor.systemGreen]), for: .normal)
        }
        minusBt.addTarget(self, action: #selector(minusAct), for: .touchUpInside)
        
        
        
        coverButtonVw.addSubview(plusBt)
        plusBt.snp.makeConstraints { (make) in
            make.leading.equalTo(amountLb.snp.trailing).offset(5)
            make.width.height.centerY.equalTo(minusBt)
        }
        
        plusBt.layer.borderWidth = 0.5
        plusBt.layer.borderColor = UIColor.lightGray.cgColor
        plusBt.layer.cornerRadius = 15
        plusBt.titleLabel?.textAlignment = .center
        if amountCount >= 99{
            plusBt.setAttributedTitle(NSAttributedString(string: "+", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40, weight: .medium), NSAttributedString.Key.foregroundColor : UIColor.gray]), for: .normal)
        }else{
            plusBt.setAttributedTitle(NSAttributedString(string: "+", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40, weight: .medium), NSAttributedString.Key.foregroundColor : UIColor.systemGreen]), for: .normal)
        }
        plusBt.addTarget(self, action: #selector(plusAct), for: .touchUpInside)
        
        
    }
    
    
    // MARK: - action Function
    @objc func minusAct(){
        
        UIView.animate(withDuration: 0.05,
            animations: {
                self.minusBt.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.05) {
                    self.minusBt.transform = CGAffineTransform.identity
                }
            })
        
        DispatchQueue.main.async { [self] in
            if self.amountCount > 1{
                
                self.amountCount -= 1
                
                
                reloadPriceAll()
                
                
                if(self.amountCount == 1){
                    self.minusBt.setAttributedTitle(NSAttributedString(string: "-", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 60, weight: .light), NSAttributedString.Key.foregroundColor : UIColor.gray]), for: .normal)
                }
                
                if self.amountCount == 98{
                    self.plusBt.setAttributedTitle(NSAttributedString(string: "+", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40, weight: .medium), NSAttributedString.Key.foregroundColor : UIColor.systemGreen]), for: .normal)
                }
                
                GioHangUtils.saveCartToUserDefault()
                
            }
        }
        
    }
    
    @objc func plusAct(){
        
        UIView.animate(withDuration: 0.05,
            animations: {
                self.plusBt.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.05) {
                    self.plusBt.transform = CGAffineTransform.identity
                }
            })
        
        DispatchQueue.main.async { [self] in
            
            print(GioHangUtils.ListGioHang.count)
            
            if self.amountCount < 99{
                
                self.amountCount += 1
                
                reloadPriceAll()
                
                if self.amountCount == 2{
                    self.minusBt.setAttributedTitle(NSAttributedString(string: "-", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 60, weight: .light), NSAttributedString.Key.foregroundColor : UIColor.systemGreen]), for: .normal)
                }
                
                if self.amountCount == 99{
                    self.plusBt.setAttributedTitle(NSAttributedString(string: "+", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40, weight: .medium), NSAttributedString.Key.foregroundColor : UIColor.gray]), for: .normal)
                }
                
                GioHangUtils.saveCartToUserDefault()
                
            }else{
                
            }
            
        }
        
    }
    
    
    func reloadPriceAll(){
        
        self.amountLb.text = "\(self.amountCount)"
        for item in GioHangUtils.ListGioHang{
            
            if item.name! == nameLb.text!{
                
                
                
                item.amount = amountCount
                gioHangVC?.reloadTotalPriceLb()
                return
            }
            
        }
        
        
    }

}
