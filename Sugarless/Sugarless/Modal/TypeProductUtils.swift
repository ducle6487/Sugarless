//
//  TypeProductUtils.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 08/01/2021.
//

import Foundation
import Firebase

protocol sentDataTo {
    func onUpdateData()
}


class TypeProductUtils{
    
    
    var ref: DatabaseReference!
    var listTypeProduct = [TypeProduct]()
    var delegate: sentDataTo?
    
    func getTypeProductFromFireBase() {
        
        ref = Database.database().reference()
        ref.child("Type").observeSingleEvent(of: .value) { [self] (snapshot) in
        
            listTypeProduct.removeAll()
            
            for item in snapshot.children{
                
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let id = dict["id"] as! String
                let name = dict["name"] as! String
                
                let type = TypeProduct.init(id: id, name: name)
                listTypeProduct.append(type)
            
            }
            
            delegate?.onUpdateData()
            
        } withCancel: { (err) in
            print(err.localizedDescription)
            
        }
        
        
        
    }
    
    
}
