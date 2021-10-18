//
//  AccountViewController.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 14/01/2021.
//

import UIKit
import SnapKit
import FirebaseAuth
import FBSDKLoginKit

class AccountViewController: UIViewController, sentProfile, sentHistoryPaymentToUI {
    
    
    // MARK: - protocol FUnction
    
    
    func onDataUpdate() {
        payedBt.setAttributedTitle(NSAttributedString.init(string: "Đã mua: \(PaymentUtils.listPayment.count)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(white: 0.4, alpha: 1), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]), for: .normal)
    }
    
    
    func onDataUpDate() {
        
        if ProfileUtils.listProfile.isEmpty{
            
            ProfileUtils.getProfile()
            
        }else{
            for item in ProfileUtils.listProfile{
                
                if item.ID == Auth.auth().currentUser?.uid{
                    
                    profile = item
                    dataToUI()
                    
                    self.removeSpinner()
                    
                    return
                    
                }
                
            }
            return
        }
        
        
        
        
    }
    

    
    // MARK: - variable
    
    var profile : ProfileUser?
    
    var scrollViewCover = UIScrollView()
    
    var userImg = UIImageView()
    var userBGVw = UIView()
    var displayNameLb = UILabel()
    var accIDLb = UILabel()
    var likedBt = UIButton()
    var commentAccLb = UILabel()
    var payedBt = UIButton()
    
    
    
    var donMuaVw = UIView()
    var diaChiVw = UIView()
    var thongTinVw = UIView()
    var matKhauVw = UIView()
    var logoutVw = UIView()
    var settingVw = UIView()
    
    
    
    // MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ProfileUtils.delegate = self
        ProfileUtils.getProfile()
        
        PaymentUtils.getPaymentFromFirebase()
        PaymentUtils.delegatePayment = self
        
        self.view.backgroundColor = .init(white: 0.9, alpha: 1)
        
        self.showSpinner(onView: self.view)
        
        
        setupUI()
        
    }
    
    // MARK: - setupUI function
    
    func dataToUI(){
        
//        print(profile?.ID)
        
        userImg.downloaded(from: URL(string: profile?.imageUrl ?? "")!)
        
        displayNameLb.text = profile?.displayName
        accIDLb.text = "ID: \(profile!.ID!)"
        commentAccLb.text = profile?.descriptionUser
        
        
    }
    
    
    func setupUI(){
        
        
        self.view.addSubview(scrollViewCover)
        scrollViewCover.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        
        self.scrollViewCover.addSubview(userBGVw)
        userBGVw.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            make.top.equalToSuperview().offset(self.view.frame.width / 20)
            make.height.equalTo(self.view.snp.height).dividedBy(4)
        }
        
        userBGVw.backgroundColor = .white
        userBGVw.layer.cornerRadius = 20
        
        
        userBGVw.addSubview(likedBt)
        likedBt.snp.makeConstraints { (make) in
            make.leading.bottom.equalToSuperview()
            make.height.equalToSuperview().dividedBy(3.2)
            make.trailing.equalTo(userBGVw.snp.centerX)
        }
        
        likedBt.setAttributedTitle(NSAttributedString.init(string: "Đã thích: 0", attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(white: 0.4, alpha: 1), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]), for: .normal)
//        likedBt.setTitle("Đã thích : 0", for: .normal)
        
        userBGVw.addSubview(payedBt)
        payedBt.snp.makeConstraints { (make) in
            make.width.height.centerY.equalTo(likedBt)
            make.trailing.equalToSuperview()
        }
        
        payedBt.setAttributedTitle(NSAttributedString.init(string: "Đã mua: 0", attributes: [NSAttributedString.Key.foregroundColor : UIColor.init(white: 0.4, alpha: 1), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)]), for: .normal)
//        payedBt.setTitle("Đã mua: 0", for: .normal)
        
        
        let line = UIView()
        userBGVw.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(self.view.frame.width / 20)
            make.bottom.equalTo(likedBt.snp.top)
            make.height.equalTo(1)
        }
        
        line.backgroundColor = .init(white: 0.7, alpha: 1)
        
        userBGVw.addSubview(userImg)
        userImg.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.view.frame.width / 20)
            make.centerY.equalTo(userBGVw.snp.top).offset(self.view.frame.height / 12)
            make.height.width.equalTo(self.view.frame.height / 10)
        }
        
        
        userImg.image = UIImage(named: "userimg")
        userImg.contentMode = .scaleAspectFit
        userImg.layer.cornerRadius = (self.view.frame.height / 10) / 2
        userImg.clipsToBounds = true
        
        
        userBGVw.addSubview(displayNameLb)
        displayNameLb.snp.makeConstraints { (make) in
            make.leading.equalTo(userImg.snp.trailing).offset(self.view.frame.width / 20)
            make.top.equalTo(userImg)
            make.height.equalTo(userImg.snp.height).dividedBy(3.5)
            make.trailing.equalToSuperview().offset(-(self.view.frame.width / 20))
        }
        
        displayNameLb.text = "Loading..."
        displayNameLb.textColor = .black
        displayNameLb.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        userBGVw.addSubview(accIDLb)
        accIDLb.snp.makeConstraints { (make) in
            make.height.trailing.leading.equalTo(displayNameLb)
            make.centerY.equalTo(userImg)
            
        }
        
        accIDLb.text = "ID: Loading..."
        accIDLb.font = .systemFont(ofSize: 15)
        accIDLb.textColor = UIColor.init(white: 0.6, alpha: 1)
        accIDLb.adjustsFontSizeToFitWidth = true
        
        
        userBGVw.addSubview(commentAccLb)
        commentAccLb.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(accIDLb)
            make.top.equalTo(accIDLb.snp.bottom).offset(self.view.frame.width / 40)
            make.bottom.lessThanOrEqualTo(line.snp.top).offset(-(self.view.frame.width / 25))
        }
        
        commentAccLb.text = "Loading..."
        commentAccLb.textColor = .init(white: 0.6, alpha: 1)
        commentAccLb.font = .italicSystemFont(ofSize: 15)
        commentAccLb.numberOfLines = 0
        commentAccLb.adjustsFontSizeToFitWidth = true
        commentAccLb.sizeToFit()
        
        
        
        self.scrollViewCover.addSubview(donMuaVw)
        donMuaVw.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(userBGVw)
            make.height.equalToSuperview().dividedBy(13)
            make.top.equalTo(userBGVw.snp.bottom).offset(self.view.frame.height / 13)
        }
        
        donMuaVw.backgroundColor = .white
        donMuaVw.layer.cornerRadius = 10
        
        //ben trong don mua view
        
        let donmuaLb = UILabel()
        let donmuaImg = UIImageView()
//        let updateLb = UILabel()
        let arrow1 = UIImageView()
        
        donMuaVw.addSubview(donmuaImg)
        donmuaImg.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.view.frame.width / 30)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(donMuaVw.snp.height).dividedBy(1.5)
        }
        
        donmuaImg.image = UIImage(named: "donmua")
        donmuaImg.contentMode = .scaleAspectFit
        
        
        donMuaVw.addSubview(donmuaLb)
        donmuaLb.snp.makeConstraints { (make) in
            make.leading.equalTo(donmuaImg.snp.trailing).offset(self.view.frame.width / 20)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().dividedBy(1.7)
        }
        
        
        donmuaLb.text = "Đơn mua"
        donmuaLb.font = .systemFont(ofSize: 20, weight: .semibold)
        
        
        donMuaVw.addSubview(arrow1)
        arrow1.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-(self.view.frame.width / 25))
            make.width.height.equalTo(donMuaVw.snp.height).dividedBy(2.2)
            make.centerY.equalToSuperview()
        }
        
        arrow1.image = UIImage(named: "backBlack")
        arrow1.contentMode = .scaleAspectFit
        arrow1.transform = CGAffineTransform(rotationAngle: .pi)
//        arrow1.layer.borderWidth = 1
        
        
        //ben trong thong tin view
        
        let thongTinLb = UILabel()
        let thongTinImg = UIImageView()
        let arrow2 = UIImageView()
        
        self.scrollViewCover.addSubview(thongTinVw)
        thongTinVw.snp.makeConstraints { (make) in
            make.height.leading.trailing.equalTo(donMuaVw)
            make.top.equalTo(donMuaVw.snp.bottom).offset(self.view.frame.width / 30)
        }
        
        thongTinVw.backgroundColor = .white
        thongTinVw.layer.cornerRadius = 10
        
        
        thongTinVw.addSubview(thongTinImg)
        thongTinImg.snp.makeConstraints { (make) in
            make.leading.height.width.equalTo(donmuaImg)
            make.centerY.equalToSuperview()
        }
        
        
        thongTinImg.image = UIImage(named: "profile")
        
        thongTinVw.addSubview(thongTinLb)
        thongTinLb.snp.makeConstraints { (make) in
            make.leading.equalTo(donmuaLb)
            make.centerY.equalToSuperview()
        }
        
        thongTinLb.text = "Thông tin tài khoản"
        thongTinLb.font = .systemFont(ofSize: 20, weight: .semibold)
        
        thongTinVw.addSubview(arrow2)
        arrow2.snp.makeConstraints { (make) in
            make.trailing.height.width.equalTo(arrow1)
            make.centerY.equalToSuperview()
        }
        
        arrow2.image = UIImage(named: "backBlack")
        arrow2.transform = CGAffineTransform(rotationAngle: .pi)
        
        
        //ben trong dia chi view
        
        let diachiImg = UIImageView()
        let diachiLb = UILabel()
        let arrow3 = UIImageView()
        
        self.scrollViewCover.addSubview(diaChiVw)
        diaChiVw.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(donMuaVw)
            make.top.equalTo(thongTinVw.snp.bottom).offset(self.view.frame.width / 30)
        }
        
        diaChiVw.backgroundColor = .white
        diaChiVw.layer.cornerRadius = 10
        
        
        diaChiVw.addSubview(diachiImg)
        diachiImg.snp.makeConstraints { (make) in
            make.leading.height.width.equalTo(donmuaImg)
            make.centerY.equalToSuperview()
        }
        
        diachiImg.image = UIImage(named: "diachi")
        
        diaChiVw.addSubview(diachiLb)
        diachiLb.snp.makeConstraints { (make) in
            make.leading.equalTo(donmuaLb)
            make.centerY.equalToSuperview()
        }
        
        diachiLb.text = "Địa chỉ"
        diachiLb.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        
        diaChiVw.addSubview(arrow3)
        arrow3.snp.makeConstraints { (make) in
            make.trailing.height.width.equalTo(arrow1)
            make.centerY.equalToSuperview()
        }
        
        arrow3.image = UIImage(named: "backBlack")
        arrow3.transform = CGAffineTransform(rotationAngle: .pi)
        
        
        //ben trong mat khau vw
        
        let matkhauImg = UIImageView()
        let matkhauLb = UILabel()
        let arrow4 = UIImageView()
        
        self.scrollViewCover.addSubview(matKhauVw)
        matKhauVw.snp.makeConstraints { (make) in
            make.height.leading.trailing.equalTo(donMuaVw)
            make.top.equalTo(diaChiVw.snp.bottom).offset(self.view.frame.width / 30)
        }
        
        matKhauVw.backgroundColor = .white
        matKhauVw.layer.cornerRadius = 10
        
        
        matKhauVw.addSubview(matkhauImg)
        matkhauImg.snp.makeConstraints { (make) in
            make.leading.height.width.equalTo(donmuaImg)
            make.centerY.equalToSuperview()
        }
        
        matkhauImg.image = UIImage(named: "password")
        
        matKhauVw.addSubview(matkhauLb)
        matkhauLb.snp.makeConstraints { (make) in
            make.leading.equalTo(donmuaLb)
            make.centerY.equalToSuperview()
        }
        
        matkhauLb.text = "Mật khẩu"
        matkhauLb.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        matKhauVw.addSubview(arrow4)
        arrow4.snp.makeConstraints { (make) in
            make.trailing.height.width.equalTo(arrow1)
            make.centerY.equalToSuperview()
        }
        
        arrow4.image = UIImage(named: "backBlack")
        arrow4.transform = CGAffineTransform(rotationAngle: .pi)
        
        
        
        //ben trong settingVw
        
        let settingImg = UIImageView()
        let settingLb = UILabel()
        let arrow5 = UIImageView()
        
        self.scrollViewCover.addSubview(settingVw)
        settingVw.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(donMuaVw)
            make.top.equalTo(matKhauVw.snp.bottom).offset(self.view.frame.width / 30)
        }
        
        settingVw.backgroundColor = .white
        settingVw.layer.cornerRadius = 10
        
        
        settingVw.addSubview(settingImg)
        settingImg.snp.makeConstraints { (make) in
            make.leading.height.width.equalTo(donmuaImg)
            make.centerY.equalToSuperview()
        }
        
        settingImg.image = UIImage(named: "setting")
        
        settingVw.addSubview(settingLb)
        settingLb.snp.makeConstraints { (make) in
            make.leading.equalTo(donmuaLb)
            make.centerY.equalToSuperview()
        }
        
        settingLb.text = "Cài đặt"
        settingLb.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        settingVw.addSubview(arrow5)
        arrow5.snp.makeConstraints { (make) in
            make.trailing.height.width.equalTo(arrow1)
            make.centerY.equalToSuperview()
        }
        
        arrow5.image = UIImage(named: "backBlack")
        arrow5.transform = CGAffineTransform(rotationAngle: .pi)
        
        
        //ben trong logout view
        
        let logoutImg = UIImageView()
        let logoutLb = UILabel()
        let arrow6 = UIImageView()
        
        
        self.scrollViewCover.addSubview(logoutVw)
        logoutVw.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(donMuaVw)
            make.top.equalTo(settingVw.snp.bottom).offset(self.view.frame.width / 30)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        
        logoutVw.layer.cornerRadius = 10
        logoutVw.backgroundColor = .white
        
        
        logoutVw.addSubview(logoutImg)
        logoutImg.snp.makeConstraints { (make) in
            make.leading.height.width.equalTo(donmuaImg)
            make.centerY.equalToSuperview()
        }
        
        logoutImg.image = UIImage(named: "logout")
        
            
        logoutVw.addSubview(logoutLb)
        logoutLb.snp.makeConstraints { (make) in
            make.leading.equalTo(donmuaLb)
            make.centerY.equalToSuperview()
        }
        
        logoutLb.text = "Đăng xuất"
        logoutLb.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        
        logoutVw.addSubview(arrow6)
        arrow6.snp.makeConstraints { (make) in
            make.trailing.equalTo(arrow1)
            make.centerY.equalToSuperview()
        }
        
        arrow6.image = UIImage(named: "backBlack")
        arrow6.transform = CGAffineTransform(rotationAngle: .pi)
        
        
        
        userBGVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userVwAct)))
        
        donMuaVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(donmuaAct)))
        
        thongTinVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(thongtinAct)))
        
        diaChiVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(diachiAct)))
        
        matKhauVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(matkhauAct)))
        
        settingVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(settingAct)))
        
        logoutVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(logoutAct)))
        
        
    }
    
    // MARK: - gesture Action Function
    
    @objc func userVwAct(){
        
        UIView.animate(withDuration: 0.1,
            animations: {
                self.userBGVw.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.userBGVw.transform = CGAffineTransform.identity
                }
            })
        if profile != nil{
            let v = UpdateInfoUserViewController()
            v.userInfo = profile
            
            let vc = UINavigationController(rootViewController: v)
            vc.modalPresentationStyle = .fullScreen
            
            
            present(vc, animated: true, completion: nil)
            
        }
        
    }
    
    @objc func donmuaAct(){
        
        UIView.animate(withDuration: 0.1,
            animations: {
                self.donMuaVw.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.donMuaVw.transform = CGAffineTransform.identity
                }
            })
        
        let vc = HistoryPaymentViewController()
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    
    @objc func thongtinAct(){
        
        UIView.animate(withDuration: 0.1,
            animations: {
                self.thongTinVw.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.thongTinVw.transform = CGAffineTransform.identity
                }
            })
        
        if profile != nil{
            let v = UpdateInfoUserViewController()
            v.userInfo = profile
            
            let vc = UINavigationController(rootViewController: v)
            vc.modalPresentationStyle = .fullScreen
            
            
            present(vc, animated: true, completion: nil)
            
        }
    }
    
    
    @objc func diachiAct(){
        
        UIView.animate(withDuration: 0.1,
            animations: {
                self.diaChiVw.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.diaChiVw.transform = CGAffineTransform.identity
                }
            })
        
        let vc = UpdateAddressViewController()
        vc.IDUser = (profile?.ID!)!
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true, completion: nil)
        
    }
 
    @objc func matkhauAct(){
        
        UIView.animate(withDuration: 0.1,
            animations: {
                self.matKhauVw.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.matKhauVw.transform = CGAffineTransform.identity
                }
            })
        
            
        if let providerData = Auth.auth().currentUser?.providerData {
            for userInfo in providerData {
                switch userInfo.providerID {
                case "facebook.com":
                    //social account
                        
                    let alert = UIAlertController(title: "Thông báo", message: "Tài khoản Facebook không thể reset mật khẩu.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Xác nhận", style: .cancel, handler: { (_) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    present(alert, animated: true, completion: nil)
                    break
                case "google.com":
                    let alert = UIAlertController(title: "Thông báo", message: "Tài khoản Google không thể reset mật khẩu.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Xác nhận", style: .cancel, handler: { (_) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    present(alert, animated: true, completion: nil)
                    break
                default:
                    print("provider is \(userInfo.providerID)")
                }
            }
        }
//        Auth.auth().sendPasswordReset(withEmail: "email@email") { error in
//            // Your code here
//        }
        
        
    }
    
    
    @objc func settingAct(){
        
        UIView.animate(withDuration: 0.1,
            animations: {
                self.settingVw.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.settingVw.transform = CGAffineTransform.identity
                }
            })
        
    }
    
    
    @objc func logoutAct(){
        
        UIView.animate(withDuration: 0.1,
            animations: {
                self.logoutVw.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.logoutVw.transform = CGAffineTransform.identity
                }
            })
        
        let alert = UIAlertController(title: "Cảnh báo!!!", message: "Bạn có muốn đăng xuất không ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Xác nhận", style: .default, handler: { (_) in
            alert.dismiss(animated: true, completion: nil)
            if Auth.auth().currentUser != nil{
                AccessToken.current = nil
                do{
                    try Auth.auth().signOut()
                    DispatchQueue.main.async {
                        let vc = LoginViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self.present(vc, animated: true, completion: nil)
                    }
                }catch let err{
                    print(err)
                }
            }
            GioHangUtils.removeCartInUserDefault()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
    
}
