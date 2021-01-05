//
//  MonAnUtils.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 05/01/2021.
//

import Foundation
import Firebase

protocol sentDataToUI {
    func onDataUpdate()
}

class MonAnUtils{
    
    var ref: DatabaseReference!
    var delegate: sentDataToUI!
    var listMonAn = [MonAn]()
    var listBestSeller = [MonAn]()
    var listFavouriting = [MonAn]()
    var listRecommend = [MonAn]()
    
    func getMonAnFromFirebase(){
        
        ref = Database.database().reference()
        ref.child("MonAn").observeSingleEvent(of: .value) { [self] (snapshot) in
            
            self.listMonAn.removeAll()
            
            for item in snapshot.children{
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let id = dict["id"] as! String
                let name = dict["name"] as! String
                let price = dict["price"] as! String
                let des = dict["description"] as! String
                let type = dict["type"] as! String
                
                let monan = MonAn(id: id, name: name, price: price, des: des, type: type)
                listMonAn.append(monan)
                
                delegate.onDataUpdate()
                
            }
            
            
        } withCancel: { (err) in
            print(err.localizedDescription)
            
        }
    }
    
    
    func getMonAnBestSellerFromFirebase(){
        
        ref = Database.database().reference()
        ref.child("BestSeller").observeSingleEvent(of: .value) { [self] (snapshot) in
            
            self.listBestSeller.removeAll()
            
            for item in snapshot.children{
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let id = dict["id"] as! String
                let name = dict["name"] as! String
                let price = dict["price"] as! String
                let des = dict["description"] as! String
                let type = dict["type"] as! String
                
                let monan = MonAn(id: id, name: name, price: price, des: des, type: type)
                listBestSeller.append(monan)
                
                delegate.onDataUpdate()
            }
            
            
        } withCancel: { (err) in
            print(err.localizedDescription)
            
        }
    }
    
    
    func getMonAnFavouriteFromFirebase(){
        
        ref = Database.database().reference()
        ref.child("Favouriting").observeSingleEvent(of: .value) { [self] (snapshot) in
            
            self.listFavouriting.removeAll()
            
            for item in snapshot.children{
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let id = dict["id"] as! String
                let name = dict["name"] as! String
                let price = dict["price"] as! String
                let des = dict["description"] as! String
                let type = dict["type"] as! String
                
                let monan = MonAn(id: id, name: name, price: price, des: des, type: type)
                listFavouriting.append(monan)
                
                delegate.onDataUpdate()
            }
            
            
        } withCancel: { (err) in
            print(err.localizedDescription)
            
        }
    }
    
    
    func getMonAnRecommendFromFirebase(){
        
        ref = Database.database().reference()
        ref.child("Recommend").observeSingleEvent(of: .value) { [self] (snapshot) in
            
            self.listRecommend.removeAll()
            
            for item in snapshot.children{
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let id = dict["id"] as! String
                let name = dict["name"] as! String
                let price = dict["price"] as! String
                let des = dict["description"] as! String
                let type = dict["type"] as! String
                
                let monan = MonAn(id: id, name: name, price: price, des: des, type: type)
                listRecommend.append(monan)
                
                delegate.onDataUpdate()
            }
            
            
        } withCancel: { (err) in
            print(err.localizedDescription)
            
        }
    }
    
    
}
