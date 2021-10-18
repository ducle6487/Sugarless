//
//  ProfileModal.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 15/01/2021.
//

import Foundation

class ProfileUser{
    
    var ID: String?
    var displayName: String?
    var imageUrl : String?
    var email : String?
    var descriptionUser : String?
    var birthDay : String?
    var gioiTinh : String?
    var phone : String?
    
    init(id:String, name: String, img: String, des: String, email: String, ns: String, gioitinh: String, phone: String){
        ID = id
        displayName = name
        imageUrl = img
        descriptionUser = des
        self.email = email
        birthDay = ns
        gioiTinh = gioitinh
        self.phone = phone
    }
    
}
