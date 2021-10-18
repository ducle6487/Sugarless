//
//  ModalUtils.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 11/01/2021.
//

import Foundation
import Firebase

protocol sentProvinceToUI{
    func onDataProvinceUpdate()
}

protocol sentDistrictToUI{
    func onDataDistrictUpdate()
}

protocol sentWardToUI{
    func onDataWardUpdate()
}

class DiaChiUtils{
    
    static var ref: DatabaseReference!
    
    static var delegateProvince: sentProvinceToUI?
    static var delegateDistrict: sentDistrictToUI?
    static var delegateWard: sentWardToUI?
    
    static var listProvince = [AddressProvince]()
    static var listDistrict = [AddressDistrict]()
    static var listWard = [AddressWard]()
    
    static func getAddressFromFirebase(){
        
        ref = Database.database().reference()
        
        ref.child("Tinh").observeSingleEvent(of: .value) { [self] (snapshot) in
            
            listProvince.removeAll()
            
            for item in snapshot.children{
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let id = dict["id"] as! Int
                let name = dict["name"] as! String
                
                let tinh = AddressProvince(id: id, name: name)
                listProvince.append(tinh)
                
            }
            
            delegateProvince?.onDataProvinceUpdate()
        }
        
        
        ref.child("Huyen").observeSingleEvent(of: .value) { [self] (snapshot) in
            
            listDistrict.removeAll()
            
            for item in snapshot.children{
                
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let idProvince = dict["tinh_id"] as! Int
                let idDistrict = dict["id"] as! Int
                let name = dict["name"] as! String
                
                let huyen = AddressDistrict(idTinh: idProvince, idQuan: idDistrict, tenQuan: name)
                listDistrict.append(huyen)
                
                
            }
            
            delegateDistrict?.onDataDistrictUpdate()
            
        }
        
        
        ref.child("Xa").observeSingleEvent(of: .value) { [self] (snapshot) in
            
            listWard.removeAll()
            
            for item in snapshot.children{
                
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let idDistrict = dict["huyen_id"] as! Int
                let idWard = dict["id"] as! Int
                let name = dict["name"] as! String
                
                let xa = AddressWard(idHuyen: idDistrict, idXa: idWard, tenXa: name)
                listWard.append(xa)
                
            }
            
            delegateWard?.onDataWardUpdate()
        }
        
        
        
        
        
    }
    
    
    
}

