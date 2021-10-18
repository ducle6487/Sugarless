//
//  PaymentModal.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 20/01/2021.
//

import Foundation


class Payment{
    
    var paymentId: String?
    var datePayment: String?
    var totalCartPayment: String?//tổng giá trị đơn hàng
    var totalPricePayment: String?//tổng gia trị ( tính cả ship )
    var message : String?
    var addressID : String?
    
    var listItem: [GioHang]?
    
    init(paymentId: String, datePay: String, totalCartPrice: String, totalPrice: String, message: String, addressID: String){
        self.paymentId = paymentId
        self.datePayment = datePay
        self.totalCartPayment = totalCartPrice
        self.totalPricePayment = totalPrice
        self.message = message
        self.addressID = addressID
    }
    
    init(paymentId: String, datePay: String, totalCartPrice: String, totalPrice: String, message: String, addressID: String, listItem: [GioHang]){
        self.paymentId = paymentId
        self.datePayment = datePay
        self.totalCartPayment = totalCartPrice
        self.totalPricePayment = totalPrice
        self.message = message
        self.addressID = addressID
        self.listItem = listItem
    }
    
}



