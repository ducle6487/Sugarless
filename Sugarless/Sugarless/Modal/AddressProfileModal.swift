//
//  AddressProfileModal.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 18/01/2021.
//

import Foundation


class AddressProfile{
    
    var name : String? // name in address
    var phone : String? // phone call to address
    var province : String?
    var district : String?
    var ward : String?
    var detailAddress : String? // detail address
    var isDefault : String?
    
    init(name: String, phone: String, province: String, district: String, ward: String, detailAddress: String, isDefault: String) {
        self.name = name
        self.phone = phone
        self.province = province
        self.district = district
        self.ward = ward
        self.detailAddress = detailAddress
        self.isDefault = isDefault
    }
    
}

class AddressDefault{
    
    var idUser : String?
    var idAddress : String?
    
    init(idUser: String, idAddress: String) {
        self.idUser = idUser
        self.idAddress = idAddress
    }
    
}
