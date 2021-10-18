//
//  AddressProfileUtils.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 19/01/2021.
//

import Foundation
import Firebase

protocol sentAddressProfileToUI {
    func onDataUpdate()
    
    func deleting()
}

protocol sentDefaultAddressToUI {
    func sending()
    
    
}

protocol reloadDataAddress {
    func upLoadAddressDefault(IDUser: String, IDAddress: String, isDefault: Bool)
    
    func reload()
}

protocol sentAddressProfileNeverDeleteToUI {
    func onDataUpdate()
}

class AddressProfileUtils{
    
    
    static var ref: DatabaseReference!
    
    static var delegate: sentAddressProfileToUI?
    
    static var delegateDefault: sentDefaultAddressToUI?
    
    static var delegateNeverDelete: sentAddressProfileNeverDeleteToUI?
    
    static var listAddress = [AddressProfile]()
    
    static var listAddressNoDelete = [AddressProfile]()
    
    static var AddressDefault : String?
    
    static var delegateReload: reloadDataAddress?
    
    
    static func sentAddressProfileToFirebase(IDUser: String, addressProfile: AddressProfile, isDefault: Bool, AddressID: String){
        
        ref = Database.database().reference()
        
        var id = AddressID
        
        if AddressID == ""{
            
            id = ref.childByAutoId().key!
            
        }
        
        
        ref.child("Address").child(id).setValue(["IDAddress" : id, "IDUser" : IDUser, "name" : addressProfile.name!, "phone" : addressProfile.phone!, "province" : addressProfile.province!, "district" : addressProfile.district!, "ward" : addressProfile.ward!, "detail" : addressProfile.detailAddress!])
        
        ref.child("AddressNoDelete").child(id).setValue(["IDAddress" : id, "IDUser" : IDUser, "name" : addressProfile.name!, "phone" : addressProfile.phone!, "province" : addressProfile.province!, "district" : addressProfile.district!, "ward" : addressProfile.ward!, "detail" : addressProfile.detailAddress!])
        
        if isDefault{
            ref.child("DefaultAddress").child(IDUser).setValue(["AddressID" : id, "UserID" : IDUser])
            
        }
        
        delegateReload?.upLoadAddressDefault(IDUser: IDUser, IDAddress: id, isDefault: isDefault)
        
        
    }
    
    static func sentDefaultAddressToFirebase(IDUser: String, IDAddress: String, isDefault: Bool){
        
        if isDefault{
            ref.child("DefaultAddress").child(IDUser).setValue(["AddressID" : IDAddress, "UserID" : IDUser])
            
        }
        
        delegateReload?.reload()
        
    }
    
    
    static func getAddressProfileFromFirebase(ID: String){
        
        ref = Database.database().reference()
        
        ref.child("Address").observeSingleEvent(of: .value) { [self] (snapshot) in
            
            listAddress.removeAll()
            
            for item in snapshot.children{
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let idAddress = dict["IDAddress"] as? String
                let idUser = dict["IDUser"] as? String
                let name = dict["name"] as? String
                let phone = dict["phone"] as? String
                let province = dict["province"] as? String
                let district = dict["district"] as? String
                let ward = dict["ward"] as? String
                let detail = dict["detail"] as? String
                
                if idUser ?? "" == ID{
                    
                    let address = AddressProfile(name: name ?? "", phone: phone ?? "", province: province ?? "", district: district ?? "", ward: ward ?? "", detailAddress: detail ?? "", isDefault: idAddress ?? "")
                    
                    listAddress.append(address)
                    
                    
                }
                
            }
        
            delegate?.onDataUpdate()
            
        }
        
        
        
    }
    
    static func getAddressDefaultFromFirebase(){
        
        ref = Database.database().reference()
        
        
        ref.child("DefaultAddress").observeSingleEvent(of: .value) { [self] (snapshot) in
            
            for item in snapshot.children{
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let idUser = dict["UserID"] as? String
                let idAddress = dict["AddressID"] as? String
                
                if idUser == Auth.auth().currentUser!.uid{
                    
                    AddressDefault = idAddress
                    
                }
                
            }
        
            delegateDefault?.sending()
            
        }
        
    }
    
    static func removeAddressFromFirebase(addressID: String){
        
        
        ref = Database.database().reference()
        
        ref.child("Address").child(addressID).removeValue()
        
        delegate?.deleting()
        
    }
    
    static func getAddressUndeleteProfileFromFirebase(ID: String){
        
        ref = Database.database().reference()
        
        ref.child("AddressNoDelete").observeSingleEvent(of: .value) { [self] (snapshot) in
            
            listAddressNoDelete.removeAll()
            
            for item in snapshot.children{
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let idAddress = dict["IDAddress"] as? String
                let idUser = dict["IDUser"] as? String
                let name = dict["name"] as? String
                let phone = dict["phone"] as? String
                let province = dict["province"] as? String
                let district = dict["district"] as? String
                let ward = dict["ward"] as? String
                let detail = dict["detail"] as? String
                
                if idUser ?? "" == ID{
                    
                    let address = AddressProfile(name: name ?? "", phone: phone ?? "", province: province ?? "", district: district ?? "", ward: ward ?? "", detailAddress: detail ?? "", isDefault: idAddress ?? "")
                    
                    listAddressNoDelete.append(address)
                    
                    
                }
                
            }
        
            delegateNeverDelete?.onDataUpdate()
            
        }
        
        
        
    }
    
    
}
