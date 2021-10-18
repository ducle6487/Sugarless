//
//  UpdateAddressTableViewCell.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 18/01/2021.
//

import UIKit
import SnapKit

class UpdateAddressTableViewCell: UITableViewCell {

    let nameLb = UILabel()
    let phoneLb = UILabel()
    let detailAddressLb = UILabel()
    let wardLb = UILabel()
    let districtLb = UILabel()
    let provinceLb = UILabel()
    let defaultLb = UILabel()
    
    let pinImg = UIImageView()
    
    let coverView = UIView()
    
    
    func setupCell(name: String, phone: String, detail: String, ward: String, district: String, province: String, isDefault : Bool){
        
        contentView.addSubview(coverView)
        coverView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(contentView.snp.height).dividedBy(1.3)
        }
        
        
        contentView.addSubview(nameLb)
        nameLb.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(15)
            make.top.equalToSuperview()
            make.bottom.equalTo(coverView.snp.top)
        }
        
        nameLb.text = name
        nameLb.font = .systemFont(ofSize: 16, weight: .semibold)
        
        
        
        coverView.addSubview(wardLb)
        wardLb.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(nameLb)
            make.height.equalToSuperview().dividedBy(5)
            make.centerY.equalToSuperview()
        }
        
        wardLb.text = ward
        wardLb.font = .systemFont(ofSize: 13)
        wardLb.textColor = .systemGray
        
        
        coverView.addSubview(detailAddressLb)
        detailAddressLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(wardLb)
            
            make.bottom.equalTo(wardLb.snp.top)
        }
        
        detailAddressLb.text = detail
        detailAddressLb.font = .systemFont(ofSize: 13)
        detailAddressLb.textColor = .systemGray
        
        
        coverView.addSubview(phoneLb)
        phoneLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(wardLb)
            make.bottom.equalTo(detailAddressLb.snp.top)
        }
        
        phoneLb.text = phone
        phoneLb.font = .systemFont(ofSize: 13)
        phoneLb.textColor = .systemGray
        
        
        coverView.addSubview(districtLb)
        districtLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(wardLb)
            make.top.equalTo(wardLb.snp.bottom)
        }
        
        districtLb.text = district
        districtLb.font = .systemFont(ofSize: 13)
        districtLb.textColor = .systemGray
        
        
        coverView.addSubview(provinceLb)
        provinceLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(wardLb)
            make.top.equalTo(districtLb.snp.bottom)
        }
        
        provinceLb.text = province
        provinceLb.font = .systemFont(ofSize: 13)
        provinceLb.textColor = .systemGray
        
        
        contentView.addSubview(defaultLb)
        defaultLb.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(contentView.frame.height / 6)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        defaultLb.text = "[Mặc định]"
        defaultLb.font = .systemFont(ofSize: 15)
        defaultLb.textColor = .systemRed
        
        defaultLb.isHidden = !isDefault
        
        
        contentView.addSubview(pinImg)
        pinImg.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(20)
            make.height.width.equalTo(contentView.snp.width).dividedBy(15)
            make.bottom.equalToSuperview().offset(-(contentView.frame.height / 8))
        }
        
        pinImg.image = UIImage(named: "pin")
        pinImg.contentMode = .scaleAspectFit
        
    }
    

}
