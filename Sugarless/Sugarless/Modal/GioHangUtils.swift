//
//  GioHangUtils.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 10/01/2021.
//

import Foundation

protocol SentDataToCart {
    func reloadData()
}

class GioHangUtils{
    
    static var ListGioHang = [GioHang]()
    
    static var delegate: SentDataToCart?
    
    static var listSave = [GioHangSave]()
    
    static func reloadCart(){
        
        delegate?.reloadData()
        
    }
    
    static func saveCartToUserDefault(){
        
        listSave.removeAll()
        
        for item in ListGioHang{
            
            GioHangUtils.listSave.append(GioHangSave(name: item.name, price: item.price, amount: item.amount, image: item.image))
            
        }
        
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(GioHangUtils.listSave), forKey:"Cart")
        
    }
    
    static func getCartSavedInUserDefault(){
        
        ListGioHang.removeAll()
        
        if let data = UserDefaults.standard.value(forKey:"Cart") as? Data {
            let listSaved = try? PropertyListDecoder().decode(Array<GioHangSave>.self, from: data)
            
            for item in listSaved!{
                
                ListGioHang.append(GioHang(name: item.name ?? "", price: item.price ?? "", image: item.image ?? "", amount: item.amount ?? 0))
                
            }
            
        }
        
    }
    
    static func removeCartInUserDefault(){
        
        listSave.removeAll()
        
        UserDefaults.standard.set(try? PropertyListEncoder().encode(GioHangUtils.listSave), forKey:"Cart")
    }
    
    
}
