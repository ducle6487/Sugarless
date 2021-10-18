//
//  HistoryPaymentTableViewCell.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 22/01/2021.
//

import UIKit

class HistoryPaymentTableViewCell: UITableViewCell {

    var addressVw = UIView()
    var addressImg = UIImageView()
    var addressArrow = UIImageView()
    var addressTitleLb = UILabel()
    var namePhoneLb = UILabel()
    var detailAddressLb = UILabel()
    var addressLb = UILabel()
    
    var dataPayment: Payment?
    
    var totalPriceLb = UILabel()
    
    var messageLb = UILabel()
    
    let screenWidth = UIScreen().bounds.width
    
    var dataAddress : AddressProfile?
    
    func setupCell(){
        
        print("setting up")
        
        contentView.addSubview(addressVw)
        addressVw.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.height.equalToSuperview().dividedBy(2)
            make.width.equalToSuperview().dividedBy(1.1)
        }
        
        addressVw.backgroundColor = .white
        
        addressVw.addSubview(addressImg)
        addressImg.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.height.width.equalTo(addressVw.snp.height).dividedBy(3.7)
        }
        
        addressImg.image = UIImage(named: "home")
        addressImg.contentMode = .scaleAspectFit
        
        
        
        addressVw.addSubview(addressTitleLb)
        addressTitleLb.snp.makeConstraints { (make) in
            make.leading.equalTo(addressImg.snp.trailing).offset(screenWidth / 50)
            make.trailing.equalToSuperview().offset(-(screenWidth / 30))
            make.height.equalToSuperview().dividedBy(3.7)
            make.centerY.equalTo(addressImg)
        }
        
        addressTitleLb.text = "Địa chỉ nhận hàng"
        
        
        addressVw.addSubview(addressLb)
        addressLb.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(addressTitleLb)
            make.height.equalToSuperview().dividedBy(4.8)
            make.bottom.equalToSuperview()
        }
        
        
        addressLb.textColor = .darkGray
        addressLb.font = .systemFont(ofSize: 12)
        
        
        addressVw.addSubview(detailAddressLb)
        detailAddressLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(addressLb)
            make.bottom.equalTo(addressLb.snp.top)
        }
        
        
        detailAddressLb.font = .systemFont(ofSize: 12)
        detailAddressLb.textColor = .darkGray
        
        addressVw.addSubview(namePhoneLb)
        namePhoneLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(detailAddressLb)
            make.bottom.equalTo(detailAddressLb.snp.top)
        }
        
        
        namePhoneLb.textColor = .darkGray
        namePhoneLb.font = .systemFont(ofSize: 12)
        
        contentView.addSubview(addressArrow)
        addressArrow.snp.makeConstraints { (make) in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(addressVw.snp.trailing)
        }
        
        addressArrow.image = UIImage(named: "backBlack")
        addressArrow.transform = CGAffineTransform.init(rotationAngle: .pi)
        addressArrow.contentMode = .scaleAspectFit
    
        
        contentView.addSubview(totalPriceLb)
        totalPriceLb.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(addressVw)
            make.height.equalToSuperview().dividedBy(7)
            make.top.equalTo(addressVw.snp.bottom)
        }
        
        totalPriceLb.textColor = .systemRed
        
        
        contentView.addSubview(messageLb)
        messageLb.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(totalPriceLb)
            make.top.equalTo(totalPriceLb.snp.bottom)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        messageLb.numberOfLines = 2
        
    }
    

    func updateAddress(){
        
        addressLb.text = "\(dataAddress!.ward!), \(dataAddress!.district!), \(dataAddress!.province!)"
        namePhoneLb.text = "\(dataAddress!.name!), \(dataAddress!.phone!)"
        detailAddressLb.text = dataAddress!.detailAddress!
        
        let attribute: NSAttributedString = "Tổng thanh toán:    \(String(describing: Int(dataPayment!.totalPricePayment!)!.formattedWithSeparator))VNĐ".attributedStringWithColor(["Tổng thanh toán:"], color: .black)
        
        totalPriceLb.attributedText = attribute
        
        messageLb.text = "Message: \(dataPayment?.message ?? "")"
        
    }
    
}
