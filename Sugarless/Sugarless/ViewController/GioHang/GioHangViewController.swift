//
//  GioHangViewController.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 10/01/2021.
//

import UIKit
import SnapKit
import FirebaseAuth

class GioHangViewController: UIViewController, SentDataToCart, sentDefaultAddressToUI, sentAddressProfileToUI {
    // MARK: - Protocol Function
    
    
    
    func sending() {
        count = count + 1
        
        if count == 2{
            count = 0
            self.removeSpinner()
        }
        
    }
    
    func onDataUpdate() {
        
        //
        count = count + 1
        
        if count == 2{
            count = 0
            self.removeSpinner()
        }
    }
    
    func deleting() {
        
        //
    }
    
    
    
    
    
    
    func reloadData() {
        DispatchQueue.main.async { [self] in
            
            listGioHang = GioHangUtils.ListGioHang
            tableView.reloadData()
            reloadTotalPriceLb()
        }
    }
    

    // MARK: - variable
    
    var count = 0
    
    var amount = 0
    
    var listGioHang = [GioHang]()
    
    fileprivate var cellid = "giohang"
    
    
    
    lazy var tableView : UITableView = {
       
        let vc = UITableView(frame: self.view.frame)
        
        vc.showsVerticalScrollIndicator = false
        
        vc.delegate = self
        vc.dataSource = self
        
        return vc
        
    }()
    
    var paymentBt = UIButton()
    var totalPrice = 0
    var totalPriceLb = UILabel()
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.showSpinner(onView: self.view)
        
        self.view.backgroundColor = .white
        GioHangUtils.delegate = self
        GioHangUtils.reloadCart()
        
        AddressProfileUtils.delegate = self
        AddressProfileUtils.delegateDefault = self
        
        AddressProfileUtils.getAddressDefaultFromFirebase()
        AddressProfileUtils.getAddressProfileFromFirebase(ID: Auth.auth().currentUser!.uid)
        
        
        
        tableView.register(GioHangTableViewCell.self, forCellReuseIdentifier: cellid)
        setupUI()
        
    }
    
    // MARK: - Setup UI
    func setupUI(){
        
        self.view.addSubview(paymentBt)
        paymentBt.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(self.view.frame.width / 20)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-10)
            make.height.equalToSuperview().dividedBy(13)
        }
        
        paymentBt.setAttributedTitle(NSAttributedString(string: "Pay Now", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .semibold)]), for: .normal)
        paymentBt.backgroundColor = .systemGreen
        paymentBt.layer.cornerRadius = 20
        paymentBt.addTarget(self, action: #selector(paymentAct), for: .touchUpInside)
        
        
        paymentBt.addSubview(totalPriceLb)
        totalPriceLb.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-(self.view.frame.width / 22))
            make.centerY.equalToSuperview().offset(-5)
            make.width.equalToSuperview().dividedBy(3.5)
        }
        
        
//        totalPriceLb.backgroundColor = .init(red: 71/255, green: 168/255, blue: 103/255, alpha: 1)
//        totalPriceLb.text = "200000000VNĐ"
        totalPriceLb.textColor = .white
        totalPriceLb.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
//        totalPriceLb.layer.borderWidth = 10
        totalPriceLb.adjustsFontSizeToFitWidth = true
        totalPriceLb.textAlignment = .right
        
//        totalPriceLb.sizeToFit()
        
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(paymentBt.snp.top)
        }
        
    }

    
}

extension GioHangViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGioHang.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid) as! GioHangTableViewCell
        cell.setupView(name: listGioHang[indexPath.item].name ?? "", image: listGioHang[indexPath.item].image ?? "", amount: listGioHang[indexPath.item].amount ?? 0, price: listGioHang[indexPath.item].price ?? "")
        cell.selectionStyle = .none
        cell.gioHangVC = self
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return CGFloat(self.view.frame.height / 6)
        
    }

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle:   UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            GioHangUtils.ListGioHang.remove(at: indexPath.row)
            GioHangUtils.saveCartToUserDefault()
            listGioHang = GioHangUtils.ListGioHang
            reloadTotalPriceLb()
            self.tableView.reloadData()
        }
    }
    
    
    
    // MARK: - Utility Function
    
    
    
    
    func reloadTotalPriceLb(){
        
        totalPrice = 0
        amount = 0
        for item in listGioHang{
            totalPrice = totalPrice + (Int(item.price!)! * Int(item.amount!))
            amount = amount + item.amount!
        }
        totalPriceLb.text = totalPrice.formattedWithSeparator + "VNĐ"
        
    }
    
    
    // MARK: - action function
    
    @objc func paymentAct(){
        
        UIView.animate(withDuration: 0.1,
            animations: {
                self.paymentBt.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.paymentBt.transform = CGAffineTransform.identity
                }
            })
        
        
        if GioHangUtils.ListGioHang.isEmpty{
            
            let alert = UIAlertController(title: "Thông báo", message: "Giỏ hàng đang trống, hãy mua thêm.", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
            
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (Timer) in
                alert.dismiss(animated: true, completion: nil)
            }
            
        }else{
            
            if AddressProfileUtils.listAddress.isEmpty{
                
                let alert = UIAlertController(title: "Thông báo", message: "Bạn chưa cập nhật địa chỉ giao hàng. Cập nhật thông qua Account -> Địa chỉ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Đã hiểu", style: .cancel, handler: { (_) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                
                
                let vc = DeliveryDescriptionViewController()

                vc.prevVC = self
                
                for item in AddressProfileUtils.listAddress{
                    
                    if item.isDefault == AddressProfileUtils.AddressDefault{
                        vc.dataAddress = item
                    }
                    
                }
                
                vc.amountCart = amount
                vc.cartPrice = totalPrice
                
                let nav = UINavigationController(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen

                present(nav, animated: true, completion: nil)
                
            }
            
        }
        
        
        
        
    }
    
    
}
