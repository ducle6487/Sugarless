//
//  ProfileUtils.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 15/01/2021.
//

import Foundation
import Firebase

protocol sentProfile {
    func onDataUpDate()
}


class ProfileUtils{
    
    static var ref: DatabaseReference!
    
    static var delegate: sentProfile?
    
    static var listProfile = [ProfileUser]()
    
    
    
    
    static func getProfile(){
        
        ref = Database.database().reference()
        
        
        ref.child("Profile").observeSingleEvent(of: .value) { [self] (snapshot) in
            
            listProfile.removeAll()
            
            for item in snapshot.children{
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let id = dict["ID"] as? String
                let name = dict["name"] as? String
                let email = dict["email"] as? String
                var img = dict["imageURL"] as? String
                let des = dict["description"] as? String
                let ns = dict["birthDay"] as? String
                let gender = dict["gender"] as? String
                let phone = dict["phone"] as? String
                
                if img == ""{
                    img = "https://www.google.com/url?sa=i&url=https%3A%2F%2Ficon-library.com%2Ficon%2Fno-user-image-icon-27.html&psig=AOvVaw0d3Uf3XpQAyDCqrFz-5uk8&ust=1611313639908000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCODZ8prxrO4CFQAAAAAdAAAAABAI"
                }
                
                let profile = ProfileUser(id: id ?? "", name: name ?? "", img: img!, des: des ?? "", email: email ?? "", ns: ns ?? "", gioitinh: gender ?? "", phone: phone ?? "")
                listProfile.append(profile)
                
            }
            
            delegate?.onDataUpDate()
            
        }
        
    }
    
    
    
    
    static func installProfile(profile: ProfileUser){
        
        ref = Database.database().reference()
        
        if profile.ID == ""{ return }
        
        if Auth.auth().currentUser?.metadata.creationDate == Auth.auth().currentUser?.metadata.lastSignInDate{
            
            ref.child("Profile").child(profile.ID!).setValue(["ID" : profile.ID, "name" : profile.displayName, "imageURL" : profile.imageUrl, "email" : profile.email, "description" : profile.descriptionUser, "birthDay" : profile.birthDay, "gender" : profile.gioiTinh, "phone" : profile.phone])
            
            
        }
        
        getProfile()
        
        
    }
    
}
