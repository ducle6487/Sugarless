//
//  PaymentModal.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 20/01/2021.
//

import Foundation
import Firebase
import FirebaseAuth

protocol paymentMakeRequest{
    
    func addItemInPayment()
    
    func addItemPaymentDone()
    
}


protocol sentHistoryPaymentToUI {
    func onDataUpdate()
}

class PaymentUtils{
    
    static var ref: DatabaseReference!
    
    static var listPayment = [Payment]()
    
    static var delegate : paymentMakeRequest?
    
    static var delegatePayment: sentHistoryPaymentToUI?
    
    fileprivate static var idPayment: String?
    
    fileprivate static let idUser = Auth.auth().currentUser!.uid
    
    static func sentPayment(paymentData: Payment){
        
        ref = Database.database().reference()
        
        let id = ref.child("Payment").child(idUser).childByAutoId().key!
        
        ref.child("Payment").child(idUser).child(id).setValue(["paymentId" : id, "addressId" : paymentData.addressID!, "datePayment" : paymentData.datePayment!, "totalCartPrice" : paymentData.totalCartPayment!, "totalPrice" : paymentData.totalPricePayment!, "message" : paymentData.message!])
        
        self.idPayment = id
        
        delegate?.addItemInPayment()
        
    }
    
    static func sentItemInPayment(){
        
        ref = Database.database().reference()
        
        for item in GioHangUtils.ListGioHang{
            
            ref.child("Payment").child(idUser).child(idPayment!).child("ItemPayment").childByAutoId().setValue(["name" : item.name!, "price" : item.price!, "amount" : item.amount!, "image" : item.image!])
            
        }
        
        delegate?.addItemPaymentDone()
    }
    
    
    static func getPaymentFromFirebase(){
        
        ref = Database.database().reference()
        
        ref.child("Payment").child("\(Auth.auth().currentUser?.uid ?? "no")").observeSingleEvent(of: .value) { (snapshot) in
            
            listPayment.removeAll()
            
            for item in snapshot.children{
                
                let snap = item as! DataSnapshot
                let dict = snap.value as! NSDictionary
                
                let paymentId = dict["paymentId"] as! String
                let datePayment = dict["datePayment"] as! String
                let addressId = dict["addressId"] as! String
                let message = dict["message"] as! String
                let totalCart = dict["totalCartPrice"] as! String
                let total = dict["totalPrice"] as! String
                
                var listItem = [GioHang]()
                
                for i in dict["ItemPayment"] as! NSDictionary{
                    
                    let dictChild = i.value as! NSDictionary
                    
                    let name = dictChild["name"] as! String
                    let image = dictChild["image"] as! String
                    let amount = dictChild["amount"] as! Int
                    let price = dictChild["price"] as! String
                    
                    listItem.append(GioHang(name: name, price: price, image: image, amount: amount))
                    
                    
                }
                
                listPayment.append(Payment(paymentId: paymentId, datePay: datePayment, totalCartPrice: totalCart, totalPrice: total, message: message, addressID: addressId, listItem: listItem))
                
            }
            
            delegatePayment?.onDataUpdate()
            
        }
        
        
        
        
    }
    
}
