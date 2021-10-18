//
//  DiaChiModal.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 11/01/2021.
//

import Foundation

class AddressProvince{
    
    var idProvince: Int?
    var nameProvince: String?
    
    init(id: Int, name: String) {
        self.idProvince = id
        self.nameProvince = name
    }
}

class AddressDistrict{
    
    var idProvince: Int?
    var idDistrict: Int?
    var nameDistrict: String?
    
    init(idTinh: Int, idQuan: Int, tenQuan: String){
        self.idProvince = idTinh
        self.idDistrict = idQuan
        self.nameDistrict = tenQuan
    }
    
}

class AddressWard{
    
    var idDistrict: Int?
    var idWard: Int?
    var nameWard: String?
    
    init(idHuyen: Int, idXa: Int, tenXa: String){
        self.idDistrict = idHuyen
        self.idWard = idXa
        self.nameWard = tenXa
    }
    
}
