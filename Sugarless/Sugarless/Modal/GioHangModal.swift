//
//  GioHangModal.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 10/01/2021.
//

import Foundation

class GioHang{
    
    var name: String?
    var price: String?
    var amount: Int?
    var image: String?
    
    init(name: String, price: String, image: String, amount: Int) {
        self.name = name
        self.price = price
        self.image = image
        self.amount = amount
    }
    
}


struct GioHangSave: Codable{
    
    var name: String?
    var price: String?
    var amount: Int?
    var image: String?
    
}
