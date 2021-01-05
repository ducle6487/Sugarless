//
//  DescriptionProductViewController.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 30/12/2020.
//

import UIKit
import SnapKit

class DescriptionProductViewController: UIViewController {

    
    // MARK: - Variable
    
    var amountCount = 1
    
    var heightLabel : Constraint?
    
    var backBt = UIButton()
    var shareBt = UIButton()
    
    var isShowLabel = false
    var isLiked = false
    
    var backgroundSVW = UIScrollView()
    
    var coverImgVw = UIImageView()
    
    var productImg = UIImageView()
    var nameLb = UILabel()
    var likedBt = UIButton()
    
    var minusBt = UIButton()
    var amountLb = UILabel()
    var plusBt = UIButton()
    
    var priceLb = UILabel()
    
    var productDetailLb = UILabel()
    var showBt = UIButton()
    
    var contentDetailLb = UILabel()
    
    var reviewLb = UILabel()
    
    var addProductBt = UIButton()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        setupUI()
        
        
    }
    
// MARK: - setup UI
    
    func setupUI(){
        
        self.view.addSubview(addProductBt)
        addProductBt.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(self.view.frame.width / 15)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalToSuperview().dividedBy(13)
        }
        
        addProductBt.layer.cornerRadius = 20
        addProductBt.setAttributedTitle(NSAttributedString(string: "Add To Cart", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        addProductBt.backgroundColor = .systemGreen
        addProductBt.addTarget(self, action: #selector(addProductAct), for: .touchUpInside)
        
        
        self.view.addSubview(backgroundSVW)
        backgroundSVW.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(addProductBt.snp.top)
        }
        
        
       backgroundSVW.addSubview(coverImgVw)
        coverImgVw.snp.makeConstraints { (make) in
            make.leading.trailing.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(self.view).dividedBy(2.5)
            
        }
        
        coverImgVw.roundCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 22)
        coverImgVw.image = UIImage(named: "test2")
        coverImgVw.contentMode = .scaleToFill
        coverImgVw.blurImage()
        coverImgVw.alpha = 0.4
        
        
        
        backgroundSVW.addSubview(backBt)
        backBt.snp.makeConstraints { (make) in
            make.leading.equalTo(coverImgVw).offset(self.view.frame.width / 15)
            make.top.equalTo(coverImgVw).offset(self.view.frame.height / 35)
            make.height.width.equalTo(self.view.frame.height / 40)
        }
        
        backBt.setBackgroundImage(UIImage(named: "backBlack"), for: .normal)
        backBt.contentMode = .scaleAspectFit
        backBt.addTarget(self, action: #selector(backAct), for: .touchUpInside)
        
        
        backgroundSVW.addSubview(shareBt)
        shareBt.snp.makeConstraints { (make) in
            make.trailing.equalTo(coverImgVw).offset(-(self.view.frame.width / 15))
            make.top.width.height.equalTo(backBt)
        }
        
        shareBt.setBackgroundImage(UIImage(named: "share"), for: .normal)
        shareBt.contentMode = .scaleAspectFit
        
        
        
        backgroundSVW.addSubview(productImg)
        productImg.snp.makeConstraints { (make) in
            make.center.equalTo(coverImgVw)
            make.width.height.lessThanOrEqualTo(coverImgVw)
        }
        
        
        productImg.image = UIImage(named: "test2")
        productImg.roundCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 22)
        productImg.contentMode = .scaleAspectFit
        
        
        backgroundSVW.addSubview(nameLb)
        nameLb.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.view.frame.width / 15)
            make.trailing.equalToSuperview().offset(-(self.view.frame.width / 5))
            make.top.equalTo(coverImgVw.snp.bottom).offset(self.view.frame.height / 40)
        }
        
        nameLb.text = "Lê Anh Đức"
        nameLb.numberOfLines = 0
        nameLb.font = .boldSystemFont(ofSize: 25)
        
        
        
        backgroundSVW.addSubview(likedBt)
        likedBt.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-(self.view.frame.width / 15))
            make.top.equalTo(nameLb)
            make.width.equalToSuperview().dividedBy(12)
            make.height.equalTo(likedBt.snp.width)
        }
        
        
        likedBt.setBackgroundImage(UIImage(named: "unliked"), for: .normal)
        likedBt.contentMode = .scaleAspectFit
        likedBt.addTarget(self, action: #selector(likeAct), for: .touchUpInside)
        
        
        backgroundSVW.addSubview(minusBt)
        minusBt.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLb)
            make.top.equalTo(nameLb.snp.bottom).offset(self.view.frame.height / 40)
            make.width.equalToSuperview().dividedBy(9)
            make.height.equalTo(minusBt.snp.width)
        }
        
        
        
        minusBt.setAttributedTitle(NSAttributedString(string: "-", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 60, weight: .light), NSAttributedString.Key.foregroundColor : UIColor.gray]), for: .normal)
        minusBt.addTarget(self, action: #selector(minusAct), for: .touchUpInside)
        
        
        backgroundSVW.addSubview(amountLb)
        amountLb.snp.makeConstraints { (make) in
            make.leading.equalTo(minusBt.snp.trailing).offset(5)
            make.height.width.equalTo(minusBt)
            make.bottom.equalTo(minusBt)
        }
        
        amountLb.textAlignment = .center
        amountLb.text = "1"
        amountLb.font = .systemFont(ofSize: 20)
        amountLb.layer.borderWidth = 0.5
        amountLb.layer.borderColor = UIColor.lightGray.cgColor
        amountLb.layer.cornerRadius = 15
        
        
        
        backgroundSVW.addSubview(plusBt)
        plusBt.snp.makeConstraints { (make) in
            make.leading.equalTo(amountLb.snp.trailing).offset(5)
            make.width.height.centerY.equalTo(minusBt)
        }
        
        plusBt.setAttributedTitle(NSAttributedString(string: "+", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40, weight: .medium), NSAttributedString.Key.foregroundColor : UIColor.systemGreen]), for: .normal)
        plusBt.addTarget(self, action: #selector(plusAct), for: .touchUpInside)
        
        
        backgroundSVW.addSubview(priceLb)
        priceLb.snp.makeConstraints { (make) in
            make.leading.equalTo(plusBt.snp.trailing).offset(10)
            make.trailing.equalTo(-(self.view.frame.width / 15))
            make.centerY.equalTo(minusBt)
        }
        
        priceLb.text = "200000đ"
        priceLb.font = .boldSystemFont(ofSize: 25)
        priceLb.textAlignment = .right
        
        let line1 = UIView()
        backgroundSVW.addSubview(line1)
        line1.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(self.view.frame.width / 15)
            make.top.equalTo(minusBt.snp.bottom).offset(self.view.frame.height / 40)
            make.height.equalTo(1)
        }

        line1.backgroundColor = .gray
        line1.alpha = 0.4
        
        
        backgroundSVW.addSubview(productDetailLb)
        productDetailLb.snp.makeConstraints { (make) in
            make.leading.equalTo(line1)
            make.top.equalTo(line1.snp.bottom).offset(self.view.frame.height / 45)
        }
        
        productDetailLb.text = "Product Detail"
        productDetailLb.font = UIFont.boldSystemFont(ofSize: 18)
        
        
        backgroundSVW.addSubview(showBt)
        showBt.snp.makeConstraints { (make) in
            make.trailing.equalTo(line1)
            make.width.height.equalTo(self.view.frame.height / 45)
            make.centerY.equalTo(productDetailLb)
        }
        
        showBt.setBackgroundImage(UIImage(named: "backBlack"), for: .normal)
        showBt.transform = CGAffineTransform.init(rotationAngle: (.pi*3) / 2)
        showBt.addTarget(self, action: #selector(showAct), for: .touchUpInside)
        
        
        backgroundSVW.addSubview(contentDetailLb)
        contentDetailLb.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(line1)
            make.top.equalTo(productDetailLb.snp.bottom).offset(self.view.frame.height / 50)
            heightLabel = make.height.equalTo(self.view.frame.height / 9).constraint
        }
        
        
        contentDetailLb.sizeToFit()
        contentDetailLb.numberOfLines = 0
        contentDetailLb.text = "Thành phần Kẹo hạt cao cấp Premi cracker: \nNhân hạt điều, đậu phộng, nhân hạt dưa hấu, nhân hạt bí đỏ, mè trắng, mạch nha, đường ăn kiêng lsomailt.  \nĐối tượng sử dụng Kẹo hạt cao cấp Premi cracker: \nKẹo hạt cao cấp Premi cracker phù hợp với tất cả mọi người, đặc biệt tốt cho người bệnh tiểu đường, tim mạch, người ăn kiêng.  \nCông dụng Kẹo hạt cao cấp Premi cracker: \n Không làm tăng cân – Phù hợp cho những ai muốn kiểm soát cân nặng của mình, và đặc biệt những người làm văn phòng quan tâm giữ “phọt”.  \n Không làm tăng đường huyết - Cho những ai bị tiểu đường.  \n Không làm dính nhớp trên tay - Thuận tiện cho ăn vặt trong giờ làm, có thể vừa ăn vừa làm trên máy tính hoặc lướt điện thoại smartphone.  \n Tiện lợi, tiết kiệm thời gian – không phải chế biến gì thêm. Thuận tiện cho người bận rộn, hoặc những chuyến đi xa nhà.  \nThực phẩm không hóa chất. Những thực phẩm này không dùng hóa chất trong phụ gia và chất bảo quản, để chất lượng sản phẩm đúng ý nghĩa có lợi cho sức khỏe người dùng.  \nCách dùng Kẹo hạt cao cấp Premi cracker: \nKẹo hạt cao cấp Premi cracker dùng ăn trực tiếp (nhai kỹ)."
        contentDetailLb.font = .systemFont(ofSize: 16)
        contentDetailLb.textColor = .gray
        
        
        let line2 = UIView()
        backgroundSVW.addSubview(line2)
        line2.snp.makeConstraints { (make) in
            make.height.leading.trailing.equalTo(line1)
            make.top.equalTo(contentDetailLb.snp.bottom).offset(self.view.frame.height / 45)
            
        }
        
        line2.backgroundColor = .gray
        line2.alpha = 0.4
        
        backgroundSVW.addSubview(reviewLb)
        reviewLb.snp.makeConstraints { (make) in
            make.leading.equalTo(line1)
            make.top.equalTo(line2.snp.bottom).offset(self.view.frame.height / 45)
        }

        reviewLb.text = "Review"
        reviewLb.font = UIFont.boldSystemFont(ofSize: 18)
        
        
        let starImg = UIImageView()
        backgroundSVW.addSubview(starImg)
        starImg.snp.makeConstraints { (make) in
            make.trailing.equalTo(line2)
            make.centerY.equalTo(reviewLb)
            make.width.equalToSuperview().dividedBy(3)
           
        }
        
        starImg.image = UIImage(named: "star")
        starImg.contentMode = .scaleAspectFit
        
        let view = UIView()
        backgroundSVW.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(starImg.snp.bottom)
            make.height.equalTo(self.view.frame.height / 45)
            make.bottom.lessThanOrEqualToSuperview()
        }
        
    }
    
    
    // MARK: - Action Function
    
    @objc func showAct(){
        
        if !isShowLabel{
            UIView.animate(withDuration: 0.5,
                animations: {

                },
                completion: { _ in
                    UIView.animate(withDuration: 0.5) {
                        self.showBt.transform = CGAffineTransform.init(rotationAngle: .pi / 2)
                    }
                })
            isShowLabel = true
            heightLabel?.deactivate()
        }else{
            UIView.animate(withDuration: 0.5,
                animations: {

                },
                completion: { _ in
                    UIView.animate(withDuration: 0.5) {
                        self.showBt.transform = CGAffineTransform.init(rotationAngle: (.pi*3) / 2)
                    }
                })
            isShowLabel = false
            heightLabel?.activate()
        }
    }
    
    

    @objc func addProductAct(){
        UIView.animate(withDuration: 0.15,
            animations: {
                self.addProductBt.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.15) {
                    self.addProductBt.transform = CGAffineTransform.identity
                }
            })
    }
    
    
    @objc func likeAct(){
        UIView.animate(withDuration: 0.2,
                       animations: { [self] in
                self.likedBt.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                if !isLiked{
                    likedBt.setBackgroundImage(UIImage(named: "liked"), for: .normal)
                    isLiked = true
                }else{
                    likedBt.setBackgroundImage(UIImage(named: "unliked"), for: .normal)
                    isLiked = false
                }
            },
            completion: { _ in
                UIView.animate(withDuration: 0.2) {
                    self.likedBt.transform = CGAffineTransform.identity
                }
            })
        
    }
    
    
    @objc func minusAct(){
        
        UIView.animate(withDuration: 0.05,
            animations: {
                self.minusBt.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.05) {
                    self.minusBt.transform = CGAffineTransform.identity
                }
            })
        
        DispatchQueue.main.async {
            if self.amountCount > 1{
                
                self.amountCount -= 1
                self.amountLb.text = "\(self.amountCount)"
                
                if(self.amountCount == 1){
                    self.minusBt.setAttributedTitle(NSAttributedString(string: "-", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 60, weight: .light), NSAttributedString.Key.foregroundColor : UIColor.gray]), for: .normal)
                }
                
                if self.amountCount == 98{
                    self.plusBt.setAttributedTitle(NSAttributedString(string: "+", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40, weight: .medium), NSAttributedString.Key.foregroundColor : UIColor.systemGreen]), for: .normal)
                }
                
            }
        }
        
    }
    
    @objc func plusAct(){
        
        UIView.animate(withDuration: 0.05,
            animations: {
                self.plusBt.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.05) {
                    self.plusBt.transform = CGAffineTransform.identity
                }
            })
        
        DispatchQueue.main.async {
            
            if self.amountCount < 99{
                
                self.amountCount += 1
                self.amountLb.text = "\(self.amountCount)"
                
                if self.amountCount == 2{
                    self.minusBt.setAttributedTitle(NSAttributedString(string: "-", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 60, weight: .light), NSAttributedString.Key.foregroundColor : UIColor.systemGreen]), for: .normal)
                }
                
                if self.amountCount == 99{
                    self.plusBt.setAttributedTitle(NSAttributedString(string: "+", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 40, weight: .medium), NSAttributedString.Key.foregroundColor : UIColor.gray]), for: .normal)
                }
                
            }else{
                
            }
            
        }
        
    }
    
    @objc func backAct(){
        
        UIView.animate(withDuration: 0.15,
            animations: {
                self.backBt.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.15) {
                    self.backBt.transform = CGAffineTransform.identity
                }
            })
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
}
