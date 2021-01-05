//
//  MonAnModal.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 05/01/2021.
//

import Foundation

class MonAn{
    
    var id : String?
    var name: String?
    var price: String?
    var description: String?
    var type:  String?
    
    init(id:String, name:String, price:String, des: String, type:String){
        self.id = id
        self.name = name
        self.price = price
        self.description = des
        self.type = type
    }
    
}
