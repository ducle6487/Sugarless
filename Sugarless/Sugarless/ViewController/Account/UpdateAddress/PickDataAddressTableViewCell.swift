//
//  PickDataAddressTableViewCell.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 19/01/2021.
//

import UIKit

class PickDataAddressTableViewCell: UITableViewCell {


    var nameLb = UILabel()
    
    func setupCell(name: String){
        
        contentView.addSubview(nameLb)
        nameLb.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        nameLb.text = name
        nameLb.font = .systemFont(ofSize: 18, weight: .semibold)
        
    }
    

}
