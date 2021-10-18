//
//  DeliveryDescriptionViewController.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 20/01/2021.
//

import UIKit
import SnapKit
import FirebaseAuth

class DeliveryDescriptionViewController: UIViewController, paymentMakeRequest {

    func addItemInPayment() {
        // them cac item vao payment tren firebase
        
        PaymentUtils.sentItemInPayment()
        
    }
    
    func addItemPaymentDone() {
        //
        
        print("done")
        
        DispatchQueue.main.async { [self] in
            
            GioHangUtils.ListGioHang.removeAll()
            GioHangUtils.removeCartInUserDefault()
            prevVC.listGioHang = GioHangUtils.ListGioHang
            prevVC.tableView.reloadData()
            prevVC.reloadData()
            
            self.removeSpinner()
            let alert = UIAlertController(title: "Chúc Mừng", message: "Bạn đã đặt hàng thành công. Chúng tôi sẽ liên hệ xác nhận với bạn", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Xác nhận", style: .cancel, handler: { (_) in
                dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
        }
        
    }

    // MARK: - Variable
    
    var prevVC = GioHangViewController()
    
    var addressVw = UIView()
    var addressImg = UIImageView()
    var addressArrow = UIImageView()
    var addressTitleLb = UILabel()
    var namePhoneLb = UILabel()
    var detailAddressLb = UILabel()
    var addressLb = UILabel()
    
    
    var CODVw = UIView()
    var shipLb = UILabel()
    var dateShipLabel = UILabel()
    var costLb = UILabel()
    
    
    var messageVw = UIView()
    var messageTF = UITextField()
    var messageLb = UILabel()
    
    
    var discountVw = UIView()
    var discountTF = UITextField()
    var discountBt = UIButton()
    
    
    var cartPriceVw = UIView()
    var cartPriceLeftLb = UILabel()
    var cartPriceRightLb = UILabel()
    
    
    var paymentMethodVw = UIView()
    var paymentMethodImg = UIImageView()
    var paymentMethodLeftLb = UILabel()
    var paymentMethodRightLb = UILabel()
    var paymentMethodArrow = UIImageView()
    
    
    var billVw = UIView()
    var cartPriceBillLb = UILabel()
    var cartPriceBillValueLb = UILabel()
    var shipPriceLb = UILabel()
    var shipPriceValueLb = UILabel()
    var discountPriceLb = UILabel()
    var discountPriceValueLb = UILabel()
    var totalPriceLb = UILabel()
    var totalPriceValueLb = UILabel()
    
    
    var acceptPaymentBt = UIButton()
    
    // variable data
    
    var dataAddress : AddressProfile?
    
    var amountCart = 0
    var cartPrice = 0
    
    var billPrice = 0
    var discountPrice = 0
    
    // MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        PaymentUtils.delegate = self
        
        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back"), for: .normal) // Image can be downloaded from here below link
        backbutton.setTitle(" Back", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal) // You can change the TitleColor
        backbutton.addTarget(self, action: #selector(dismissAct), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        
        self.view.backgroundColor = .init(white: 0.9, alpha: 1)
        
        self.navigationItem.title = "Vận chuyển"
        
        self.hideKeyboardWhenTappedAround()
        
        setupUI()
        
    }
    
    // MARK: - setup user interface
    
    func setupUI(){
        
        self.view.addSubview(addressVw)
        addressVw.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(5)
            make.height.equalToSuperview().dividedBy(10)
        }
        
        addressVw.backgroundColor = .white
        
        addressVw.addSubview(addressImg)
        addressImg.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.view.frame.height / 150)
            make.top.equalToSuperview().offset(self.view.frame.height / 100)
            make.height.width.equalTo(addressVw.snp.height).dividedBy(4)
        }
        
        addressImg.image = UIImage(named: "home")
        addressImg.contentMode = .scaleAspectFit
        
        
        
        addressVw.addSubview(addressTitleLb)
        addressTitleLb.snp.makeConstraints { (make) in
            make.leading.equalTo(addressImg.snp.trailing).offset(self.view.frame.height / 150)
            make.trailing.equalToSuperview().offset(-(self.view.frame.height / 40))
            make.height.equalToSuperview().dividedBy(4)
            make.centerY.equalTo(addressImg)
        }
        
        addressTitleLb.text = "Địa chỉ nhận hàng"
        
        
        addressVw.addSubview(addressLb)
        addressLb.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(addressTitleLb)
            make.height.equalToSuperview().dividedBy(6)
            make.bottom.equalToSuperview().offset(-(self.view.frame.height / 100))
        }
        
        
        addressLb.textColor = .darkGray
        addressLb.font = .systemFont(ofSize: 12)
        
        
        addressVw.addSubview(detailAddressLb)
        detailAddressLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(addressLb)
            make.bottom.equalTo(addressLb.snp.top)
        }
        
        
        detailAddressLb.font = .systemFont(ofSize: 12)
        detailAddressLb.textColor = .darkGray
        
        addressVw.addSubview(namePhoneLb)
        namePhoneLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(detailAddressLb)
            make.bottom.equalTo(detailAddressLb.snp.top)
        }
        
        
        namePhoneLb.textColor = .darkGray
        namePhoneLb.font = .systemFont(ofSize: 12)
        
        addressVw.addSubview(addressArrow)
        addressArrow.snp.makeConstraints { (make) in
            make.trailing.top.bottom.equalToSuperview()
            make.leading.equalTo(addressLb.snp.trailing)
        }
        
        addressArrow.image = UIImage(named: "backBlack")
        addressArrow.transform = CGAffineTransform.init(rotationAngle: .pi)
        addressArrow.contentMode = .scaleAspectFit
        
        addressVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addressAct)))
        
        
        self.view.addSubview(CODVw)
        CODVw.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(13)
            make.top.equalTo(addressVw.snp.bottom).offset(5)
        }
        
        CODVw.backgroundColor = .white
        
        let coverVw1 = UIView()
        
        CODVw.addSubview(coverVw1)
        coverVw1.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().inset(self.view.frame.height / 130)
            make.trailing.equalTo(CODVw.snp.centerX)
            make.top.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        
        coverVw1.addSubview(shipLb)
        shipLb.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        shipLb.text = "Phí vận chuyển: "
        shipLb.textColor = .darkGray
        shipLb.font = .systemFont(ofSize: 15)
        
        let coverVw2 = UIView()
        
        CODVw.addSubview(coverVw2)
        coverVw2.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(coverVw1)
            make.top.equalTo(coverVw1.snp.bottom)
        }
        
        
        coverVw2.addSubview(dateShipLabel)
        dateShipLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        dateShipLabel.text = "Giao hàng vào 23/1 - 25/1"
        dateShipLabel.textColor = .darkGray
        dateShipLabel.font = .systemFont(ofSize: 12)
        
        
        CODVw.addSubview(costLb)
        costLb.snp.makeConstraints { (make) in
            make.leading.equalTo(CODVw.snp.centerX)
            make.trailing.equalToSuperview().offset(-(self.view.frame.height / 130))
            make.centerY.equalToSuperview()
        }
        
        costLb.text = Int(30000).formattedWithSeparator + "VNĐ"
        costLb.font = .systemFont(ofSize: 16)
        costLb.textColor = .systemRed
        costLb.textAlignment = .right
        
        
        self.view.addSubview(messageVw)
        messageVw.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(CODVw.snp.bottom).offset(5)
            make.height.equalToSuperview().dividedBy(18)
        }
        
        messageVw.backgroundColor = .white
        
        
        messageVw.addSubview(messageLb)
        messageLb.snp.makeConstraints { (make) in
            make.leading.equalTo(shipLb)
            make.centerY.equalToSuperview()
        }
        
        messageLb.text = "Tin nhắn: "
        messageLb.font = .systemFont(ofSize: 15)
        
        
        messageVw.addSubview(messageTF)
        messageTF.snp.makeConstraints { (make) in
            make.leading.equalTo(messageLb.snp.trailing)
            make.trailing.equalToSuperview().offset(-(self.view.frame.height / 130))
            make.centerY.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        
        messageTF.placeholder = "Lưu ý cho người bán..."
        messageTF.font = .systemFont(ofSize: 13)
        messageTF.textAlignment = .right
        messageTF.clearButtonMode = .whileEditing
        
        
        
        
        
        
        self.view.addSubview(cartPriceVw)
        cartPriceVw.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(messageVw)
            make.top.equalTo(messageVw.snp.bottom).offset(5)
        }
        
        cartPriceVw.backgroundColor = .white
        
        cartPriceVw.addSubview(cartPriceLeftLb)
        cartPriceLeftLb.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.view.frame.height / 130)
            make.width.equalToSuperview().dividedBy(1.9)
            make.centerY.equalToSuperview()
        }
        
        
        cartPriceLeftLb.font = .systemFont(ofSize: 16)
        cartPriceLeftLb.adjustsFontSizeToFitWidth = true
        cartPriceLeftLb.text = "Tổng số tiền (\(amountCart) sản phẩm):"
        
        
        cartPriceVw.addSubview(cartPriceRightLb)
        cartPriceRightLb.snp.makeConstraints { (make) in
            make.leading.equalTo(cartPriceLeftLb.snp.trailing)
            make.trailing.equalToSuperview().offset(-(self.view.frame.height / 130))
            make.centerY.equalToSuperview()
        }
        
        cartPriceRightLb.font = .systemFont(ofSize: 16, weight: .bold)
        cartPriceRightLb.textColor = .systemRed
        cartPriceRightLb.text = cartPrice.formattedWithSeparator + "VNĐ"
        cartPriceRightLb.textAlignment = .right
        
        
        
        self.view.addSubview(discountVw)
        discountVw.snp.makeConstraints { (make) in
            
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(cartPriceVw)
            make.top.equalTo(cartPriceVw.snp.bottom).offset(5)
        }
        
        discountVw.backgroundColor = .init(white: 0.95, alpha: 1)
        
        
        discountVw.addSubview(discountTF)
        discountTF.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.view.frame.height / 130)
            make.width.equalToSuperview().dividedBy(1.5)
            make.height.equalToSuperview().dividedBy(1.5)
            make.centerY.equalToSuperview()
        }
        
        
        discountTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        discountTF.leftViewMode = .always
        discountTF.placeholder = "Mã giảm giá"
        discountTF.layer.borderWidth = 0.5
        discountTF.layer.borderColor = UIColor.darkGray.cgColor
        discountTF.backgroundColor = .white
        discountTF.layer.cornerRadius = 10
        discountTF.font = .systemFont(ofSize: 15)
        
        
        discountVw.addSubview(discountBt)
        discountBt.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-(self.view.frame.height / 130))
            make.leading.equalTo(discountTF.snp.trailing).offset(self.view.frame.height / 130)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().dividedBy(1.5)
        }
        
        
        discountBt.setAttributedTitle(NSAttributedString(string: "Áp dụng", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15)]), for: .normal)
        discountBt.layer.cornerRadius = 10
        discountBt.backgroundColor = .systemBlue
        discountBt.addTarget(self, action: #selector(discountAct), for: .touchUpInside)
        
        
        self.view.addSubview(paymentMethodVw)
        paymentMethodVw.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(discountVw.snp.bottom).offset(5)
            make.height.equalTo(discountVw.snp.height)
        }
        
        paymentMethodVw.backgroundColor = .white
        
        
        paymentMethodVw.addSubview(paymentMethodImg)
        paymentMethodImg.snp.makeConstraints { (make) in
            make.leading.height.width.equalTo(addressImg)
            make.centerY.equalToSuperview()
        }
        
        paymentMethodImg.image = UIImage(named: "payment")
        paymentMethodImg.contentMode = .scaleAspectFit
        
        
        paymentMethodVw.addSubview(paymentMethodLeftLb)
        paymentMethodLeftLb.snp.makeConstraints { (make) in
            make.leading.equalTo(paymentMethodImg.snp.trailing).offset(self.view.frame.height / 130)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(paymentMethodVw.snp.centerX)
        }
        
        
        paymentMethodLeftLb.font = .systemFont(ofSize: 16)
        paymentMethodLeftLb.text = "Hình thức thanh toán"
        paymentMethodLeftLb.adjustsFontSizeToFitWidth = true
        
        
        paymentMethodVw.addSubview(paymentMethodArrow)
        paymentMethodArrow.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-(self.view.frame.height / 130))
            make.centerY.equalToSuperview()
            make.height.width.equalTo(addressArrow)
        }
        
        paymentMethodArrow.image = UIImage(named: "backBlack")
        paymentMethodArrow.transform = CGAffineTransform.init(rotationAngle: .pi)
        paymentMethodArrow.contentMode = .scaleAspectFit
        
        
        paymentMethodVw.addSubview(paymentMethodRightLb)
        paymentMethodRightLb.snp.makeConstraints { (make) in
            make.trailing.equalTo(paymentMethodArrow.snp.leading).offset(-(self.view.frame.height / 130))
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().dividedBy(1.7)
            make.width.equalToSuperview().dividedBy(2.6)
        }
        
        paymentMethodRightLb.font = .systemFont(ofSize: 16)
        paymentMethodRightLb.text = "Thanh toán khi nhận hàng"
        paymentMethodRightLb.numberOfLines = 2
        paymentMethodRightLb.textAlignment = .right
        paymentMethodRightLb.adjustsFontSizeToFitWidth = true
        
        
        
        self.view.addSubview(billVw)
        billVw.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(6.5)
            make.top.equalTo(paymentMethodVw.snp.bottom)
        }
        
        billVw.backgroundColor = .white
        
        
        billVw.addSubview(totalPriceLb)
        totalPriceLb.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.view.frame.height / 130)
            make.bottom.equalToSuperview().offset(-((self.view.frame.height / 6) / 16))
            make.trailing.equalTo(billVw.snp.centerX)
            make.height.equalToSuperview().dividedBy(3.5)
        }
        
        
        totalPriceLb.text = "Tổng thanh toán "
        totalPriceLb.font = .systemFont(ofSize: 18)
        
        
        let coverVw3 = UIView()
        billVw.addSubview(coverVw3)
        coverVw3.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(totalPriceLb)
            make.top.equalToSuperview().offset((self.view.frame.height / 6) / 16)
            make.bottom.equalTo(totalPriceLb.snp.top)
        }
        
        
        
        coverVw3.addSubview(cartPriceBillLb)
        cartPriceBillLb.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3)
        }
        
        cartPriceBillLb.text = "Tổng tiền hàng"
        cartPriceBillLb.font = .systemFont(ofSize: 14)
        cartPriceBillLb.textColor = .darkGray
        
        
        billVw.addSubview(cartPriceBillValueLb)
        cartPriceBillValueLb.snp.makeConstraints { (make) in
            make.leading.equalTo(coverVw3.snp.trailing)
            make.height.equalTo(cartPriceBillLb)
            make.trailing.equalToSuperview().offset(-(self.view.frame.height / 130))
            make.centerY.equalTo(cartPriceBillLb)
        }
        
        
        cartPriceBillValueLb.text = cartPrice.formattedWithSeparator + "VNĐ"
        cartPriceBillValueLb.font = .systemFont(ofSize: 14)
        cartPriceBillValueLb.textColor = .darkGray
        cartPriceBillValueLb.textAlignment = .right
        
        
        coverVw3.addSubview(shipPriceLb)
        shipPriceLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(cartPriceBillLb)
            make.top.equalTo(cartPriceBillLb.snp.bottom)
        }
        
        
        shipPriceLb.text = "Phí vận chuyển"
        shipPriceLb.font = .systemFont(ofSize: 14)
        shipPriceLb.textColor = .darkGray
        
        
        billVw.addSubview(shipPriceValueLb)
        shipPriceValueLb.snp.makeConstraints { (make) in
            make.leading.height.trailing.equalTo(cartPriceBillValueLb)
            make.centerY.equalTo(shipPriceLb)
        }
        
        shipPriceValueLb.text = Int(30000).formattedWithSeparator + "VNĐ"
        shipPriceValueLb.textColor = .darkGray
        shipPriceValueLb.font = .systemFont(ofSize: 14)
        shipPriceValueLb.textAlignment = .right
        
        
        coverVw3.addSubview(discountPriceLb)
        discountPriceLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(shipPriceLb)
            make.top.equalTo(shipPriceLb.snp.bottom)
        }
        
        
        discountPriceLb.text = "Giảm giá"
        discountPriceLb.font = .systemFont(ofSize: 14)
        discountPriceLb.textColor = .darkGray
        
        
        billVw.addSubview(discountPriceValueLb)
        discountPriceValueLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(cartPriceBillValueLb)
            make.centerY.equalTo(discountPriceLb)
        }
        
        discountPriceValueLb.text = "-0VNĐ"
        discountPriceValueLb.textColor = .darkGray
        discountPriceValueLb.textAlignment = .right
        discountPriceValueLb.font = .systemFont(ofSize: 14)
        
        
        billVw.addSubview(totalPriceValueLb)
        totalPriceValueLb.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(discountPriceValueLb)
            make.height.centerY.equalTo(totalPriceLb)
        }
        
        totalPriceValueLb.font = .systemFont(ofSize: 18)
        totalPriceValueLb.textColor = .systemRed
        totalPriceValueLb.textAlignment = .right
        totalPriceValueLb.text = "0VNĐ"
        
        
        let coverVw4 = UIView()
        self.view.addSubview(coverVw4)
        coverVw4.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(billVw.snp.bottom)
        }
        
        
        coverVw4.addSubview(acceptPaymentBt)
        acceptPaymentBt.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(self.view.frame.width / 15)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3.5)
        }
        
        acceptPaymentBt.backgroundColor = .systemGreen
        acceptPaymentBt.setAttributedTitle(NSAttributedString(string: "Xác nhận", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .semibold)]), for: .normal)
        acceptPaymentBt.addTarget(self, action: #selector(acceptPaymentAct), for: .touchUpInside)
        acceptPaymentBt.layer.cornerRadius = 20
        
        solveBillPrice()
        updateAddress()
    }
    
    
    
    
    

    // MARK: - Action Function
    
    
    @objc func dismissAct(){
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc func addressAct(){
        
        let vc = UpdateAddressViewController()
        vc.prevVC = self
        vc.typePresent = "delivery"
        vc.IDUser = Auth.auth().currentUser!.uid
        vc.addressDefaultID = (dataAddress?.isDefault!)!
        
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
        
    }
    
    
    @objc func discountAct(){
        
        UIView.animate(withDuration: 0.15,
            animations: {
                self.discountBt.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.15) {
                    self.discountBt.transform = CGAffineTransform.identity
                }
            })
        
    }
    
    
    @objc func acceptPaymentAct(){
        
        UIView.animate(withDuration: 0.1,
            animations: {
                self.acceptPaymentBt.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.acceptPaymentBt.transform = CGAffineTransform.identity
                }
            })
        
        
        if !GioHangUtils.ListGioHang.isEmpty && AddressProfileUtils.AddressDefault != ""{
            
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd, HH:mm:ss"
            let result = formatter.string(from: date)

            print(result)

            print(GioHangUtils.ListGioHang.count)

            let payment = Payment(paymentId: "", datePay: result, totalCartPrice: "\(cartPrice)", totalPrice: "\(billPrice)", message: messageTF.text ?? "", addressID: (dataAddress!.isDefault)!)
            
            

            
            self.showSpinner(onView: self.view)

            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (Timer) in
                PaymentUtils.sentPayment(paymentData: payment)
                PaymentUtils.getPaymentFromFirebase()
            }
            
        }
        
        
    }
    
    
    // MARK: - Utility Function
    
    
    func solveBillPrice(){
        
        billPrice = cartPrice + 30000 - discountPrice
        
        totalPriceValueLb.text = billPrice.formattedWithSeparator + "VNĐ"
        
        
    }
    
    func updateAddress(){
        
        addressLb.text = "\(dataAddress!.ward!), \(dataAddress!.district!), \(dataAddress!.province!)"
        namePhoneLb.text = "\(dataAddress!.name!), \(dataAddress!.phone!)"
        detailAddressLb.text = dataAddress!.detailAddress!
        
    }
    

}
