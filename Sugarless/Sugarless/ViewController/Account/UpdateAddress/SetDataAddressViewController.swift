//
//  SetDataAddressViewController.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 18/01/2021.
//

import UIKit

class SetDataAddressViewController: UIViewController, sentProvinceToUI, sentDistrictToUI, sentWardToUI{
    
    func onDataWardUpdate(){
        
//        print(DiaChiUtils.listWard.count)
        
        removeSpinerCheck()
        
    }
    

    func onDataDistrictUpdate() {
        
//        print(DiaChiUtils.listDistrict.count)
    
        if district != ""{
            
            for item in DiaChiUtils.listDistrict{
                
                if item.nameDistrict! == district{
                    
                    districtID = item.idDistrict!
                    
                }
                
            }
            
        }
        
        removeSpinerCheck()
        
    }

    
    func onDataProvinceUpdate() {
        
//        print(DiaChiUtils.listProvince.count)
        
        if province != ""{
            
            for item in DiaChiUtils.listProvince{
                
                if item.nameProvince! == province{
                    provinceID = item.idProvince!
                }
                
            }
            
        }
        
        removeSpinerCheck()
        
    }
    

    // MARK: - Variable
    
    var isAdd = false
    
    var prevVC = UpdateAddressViewController()
    
    var provinceID = -1
    var districtID = -1
    
    var userID = ""
    
    var removeSpinner = 0
    
    var nameLb = UILabel()
    var nameTF = UITextField()
    
    var phoneLb = UILabel()
    var phoneTF = UITextField()
    
    var provinceLb = UILabel()
    var provinceValueLb = UILabel()
    
    var districtLb = UILabel()
    var districtValueLb = UILabel()
    
    var wardLb = UILabel()
    var wardValueLb = UILabel()
    
    var detailAddressLb1 = UILabel()
    var detailAddressLb2 = UILabel()
    var detailAddressTF = UITextField()
    
    var isDefaultLb = UILabel()
    var isDefaultSw = UISwitch()
    
    var addressData : AddressProfile?
    
    var deleteBt = UIButton()
    
    //variable data
    
    var name = ""
    var phone = ""
    var province = ""
    var district = ""
    var ward = ""
    var detail = ""
    var isEnable = false
    var addressID = ""
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back"), for: .normal) // Image can be downloaded from here below link
        backbutton.setTitle(" Back", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal) // You can change the TitleColor
        backbutton.addTarget(self, action: #selector(dismissAct), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Địa chỉ mới"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAct))
        
        self.hideKeyboardWhenTappedAround()
        
        self.showSpinner(onView: (self.view))
        
        isDefaultSw.isOn = false
        isDefaultSw.setOn(false, animated: true)
//        isDefaultSw.addTarget(self, action: #selector(switchAct), for: .valueChanged)
        
        setupUI()
        
        DiaChiUtils.getAddressFromFirebase()
        DiaChiUtils.delegateWard = self
        DiaChiUtils.delegateDistrict = self
        DiaChiUtils.delegateProvince = self
        
        
    }
    
    // MARK: - setup User Interface
    
    
    func setupUI(){
        
        self.view.addSubview(nameLb)
        nameLb.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(10)
            make.height.equalToSuperview().dividedBy(19)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.trailing.equalTo(self.view.snp.centerX)
        }
        
        nameLb.text = "Họ & Tên"
        nameLb.font = .systemFont(ofSize: 16)
        
        self.view.addSubview(nameTF)
        nameTF.snp.makeConstraints { (make) in
            make.leading.equalTo(self.view.snp.centerX)
            make.trailing.equalToSuperview().offset(-10)
            make.height.centerY.equalTo(nameLb)
        }
        
        nameTF.textAlignment = .right
        nameTF.placeholder = "Điền Họ & Tên"
        nameTF.font = .systemFont(ofSize: 16)
        nameTF.text = name
        
        
        let line1 = UIView()
        self.view.addSubview(line1)
        line1.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(nameTF.snp.bottom)
        }
        
        line1.backgroundColor = .init(white: 0.85, alpha: 1)
        
        
        self.view.addSubview(phoneLb)
        phoneLb.snp.makeConstraints { (make) in
            make.leading.height.trailing.equalTo(nameLb)
            make.top.equalTo(line1.snp.bottom)
        }
        
        phoneLb.text = "Số điện thoại"
        phoneLb.font = .systemFont(ofSize: 16)
        
        
        self.view.addSubview(phoneTF)
        phoneTF.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(nameTF)
            make.centerY.equalTo(phoneLb)
        }
        
        phoneTF.placeholder = "Điền Số điện thoại"
        phoneTF.font = .systemFont(ofSize: 16)
        phoneTF.textAlignment = .right
        phoneTF.text = phone
        phoneTF.keyboardType = .phonePad
        
        let line2 = UIView()
        self.view.addSubview(line2)
        line2.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(phoneTF.snp.bottom)
        }
        
        line2.backgroundColor = .init(white: 0.85, alpha: 1)
        
        
        self.view.addSubview(provinceLb)
        provinceLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(nameLb)
            make.top.equalTo(line2.snp.bottom)
        }
        
        provinceLb.text = "Tỉnh/Thành phố"
        provinceLb.font = .systemFont(ofSize: 16)
        
        
        
        let arrow1 = UIImageView()
        self.view.addSubview(arrow1)
        arrow1.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-5)
            make.width.height.equalTo(nameTF.snp.height).dividedBy(2.5)
            make.centerY.equalTo(provinceLb)
        }
        
        arrow1.image = UIImage(named: "backBlack")
        arrow1.transform = CGAffineTransform.init(rotationAngle: .pi)
        arrow1.contentMode = .scaleAspectFit
        
        self.view.addSubview(provinceValueLb)
        provinceValueLb.snp.makeConstraints { (make) in
            make.trailing.equalTo(arrow1.snp.leading)
            make.leading.equalTo(provinceLb.snp.trailing)
            make.height.centerY.equalTo(provinceLb)
        }
        
        provinceValueLb.text = "Điền Tỉnh/Thành phố"
        provinceValueLb.textAlignment = .right
        provinceValueLb.font = .systemFont(ofSize: 16)
        provinceValueLb.textColor = UIColor.init(white: 0.75, alpha: 1)
        if province != ""{
            provinceValueLb.text = province
            provinceValueLb.textColor = .black
        }
        
        
        let line3 = UIView()
        self.view.addSubview(line3)
        line3.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.top.equalTo(provinceValueLb.snp.bottom)
        }
        
        line3.backgroundColor = .init(white: 0.85, alpha: 1)
        
        
        self.view.addSubview(districtLb)
        districtLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(provinceLb)
            make.top.equalTo(line3.snp.bottom)
        }
        
        districtLb.text = "Quận/Huyện"
        districtLb.font = .systemFont(ofSize: 16)
        
        
        let arrow2 = UIImageView()
        self.view.addSubview(arrow2)
        arrow2.snp.makeConstraints { (make) in
            make.trailing.width.height.equalTo(arrow1)
            make.centerY.equalTo(districtLb)
        }
        
        arrow2.image = UIImage(named: "backBlack")
        arrow2.contentMode = .scaleAspectFit
        arrow2.transform = CGAffineTransform.init(rotationAngle: .pi)
        
        
        self.view.addSubview(districtValueLb)
        districtValueLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(provinceValueLb)
            make.centerY.equalTo(districtLb)
        }
        
        districtValueLb.text = "Điền Quận/Huyện"
        districtValueLb.textAlignment = .right
        districtValueLb.font = .systemFont(ofSize: 16)
        districtValueLb.textColor = UIColor.init(white: 0.75, alpha: 1)
        if district != ""{
            districtValueLb.text = district
            districtValueLb.textColor = .black
        }
        
        
        let line4 = UIView()
        self.view.addSubview(line4)
        line4.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(line1)
            make.top.equalTo(districtValueLb.snp.bottom)
        }
        
        line4.backgroundColor = .init(white: 0.85, alpha: 1)
        
        self.view.addSubview(wardLb)
        wardLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(provinceLb)
            make.top.equalTo(line4.snp.bottom)
        }
        
        wardLb.text = "Phường/Xã"
        wardLb.font = .systemFont(ofSize: 16)
        
        let arrow3 = UIImageView()
        self.view.addSubview(arrow3)
        arrow3.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(arrow1)
            make.centerY.equalTo(wardLb)
        }
        
        arrow3.image = UIImage(named: "backBlack")
        arrow3.contentMode = .scaleAspectFit
        arrow3.transform = CGAffineTransform.init(rotationAngle: .pi)
        
        self.view.addSubview(wardValueLb)
        wardValueLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(provinceValueLb)
            make.centerY.equalTo(wardLb)
        }
        
        wardValueLb.text = "Điền Phường/Xã"
        wardValueLb.textColor = UIColor.init(white: 0.75, alpha: 1)
        wardValueLb.font = .systemFont(ofSize: 16)
        wardValueLb.textAlignment = .right
        if ward != ""{
            wardValueLb.text = ward
            wardValueLb.textColor = .black
        }
        
        
        let line5 = UIView()
        self.view.addSubview(line5)
        line5.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(line1)
            make.top.equalTo(wardLb.snp.bottom)
        }
        
        line5.backgroundColor = .init(white: 0.85, alpha: 1)
        
        
        self.view.addSubview(detailAddressLb1)
        detailAddressLb1.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalTo(line5.snp.bottom).offset(20)
            make.height.equalTo(nameLb).dividedBy(2.2)
        }
        
        detailAddressLb1.text = "Địa chỉ cụ thể"
        detailAddressLb1.font = .systemFont(ofSize: 15)
        
        
        self.view.addSubview(detailAddressLb2)
        detailAddressLb2.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(detailAddressLb1)
            make.height.equalTo(nameLb).dividedBy(3)
            make.top.equalTo(detailAddressLb1.snp.bottom)
        }
        
        detailAddressLb2.text = "Số nhà, tên toà nhà, tên đường, tên khu vực"
        detailAddressLb2.font = .systemFont(ofSize: 12)
        detailAddressLb2.textColor = UIColor.init(white: 0.5, alpha: 1)
        
        self.view.addSubview(detailAddressTF)
        detailAddressTF.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(10)
            make.height.equalTo(nameLb)
            make.top.equalTo(detailAddressLb2.snp.bottom)
        }
        
        detailAddressTF.placeholder = "Nhập địa chỉ cụ thể"
        detailAddressTF.font = .systemFont(ofSize: 16)
        detailAddressTF.text = detail
        
        
        let line6 = UIView()
        self.view.addSubview(line6)
        line6.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(20)
            make.top.equalTo(detailAddressTF.snp.bottom)
        }
        
        line6.backgroundColor = .init(white: 0.9, alpha: 1)
        
        
        self.view.addSubview(isDefaultLb)
        isDefaultLb.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(nameLb)
            make.top.equalTo(line6.snp.bottom)
        }
        
        isDefaultLb.text = "Đặt làm địa chỉ mặc định"
        isDefaultLb.font = .systemFont(ofSize: 16)
        
        
        self.view.addSubview(isDefaultSw)
        isDefaultSw.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalTo(isDefaultLb)
        }
        isDefaultSw.isOn = isEnable
        if isEnable{
            
            isDefaultSw.isUserInteractionEnabled = false
            
        }
        
        
        let line7 = UIView()
        self.view.addSubview(line7)
        line7.snp.makeConstraints { (make) in
            make.top.equalTo(isDefaultLb.snp.bottom)
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        line7.backgroundColor = .init(white: 0.9, alpha: 1)
        
        
        if !isAdd{
            line7.addSubview(deleteBt)
            deleteBt.snp.makeConstraints { (make) in
                make.leading.bottom.trailing.equalToSuperview().inset(self.view.frame.width / 20)
                make.height.equalTo(self.view.snp.height).dividedBy(14)
            }
            
            deleteBt.backgroundColor = .systemRed
            deleteBt.layer.cornerRadius = 20
            deleteBt.setAttributedTitle(NSAttributedString(string: "Xoá", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .semibold)]), for: .normal)
            deleteBt.addTarget(self, action: #selector(deleteAct), for: .touchUpInside)
        }
        
        
        provinceValueLb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(provinceAct)))
        provinceValueLb.isUserInteractionEnabled = true
        
        districtValueLb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(districtAct)))
        districtValueLb.isUserInteractionEnabled = true
        
        wardValueLb.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(wardAct)))
        wardValueLb.isUserInteractionEnabled = true
        
    }
    
    
    // MARK: - action Function
    
    @objc func dismissAct(){
        
        let alert = UIAlertController(title: "Chú ý", message: "Thay đổi chưa được lưu, bạn có chắc muốn thoát trang này không?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Không", style: .cancel, handler: { (_) in
            
            alert.dismiss(animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Đồng ý", style: .default, handler: { (_) in
            
            alert.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    @objc func saveAct(){
        
        if nameTF.text == ""{
            
            let alert = UIAlertController(title: "Cảnh báo!!", message: "Hãy điền Họ & Tên", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Thử lại", style: .cancel, handler: { (UIAlertAction) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            present(alert, animated: true, completion: nil)
            return
            
        }
        
        if phoneTF.text == ""{
            
            let alert = UIAlertController(title: "Cảnh báo!!", message: "Hãy điền Số điện thoại", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Thử lại", style: .cancel, handler: { (UIAlertAction) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            present(alert, animated: true, completion: nil)
            return
            
        }else{
            
            if !ValidationPhoneNumber(phoneTF.text){
                
                let alert = UIAlertController(title: "Cảnh báo!!", message: "Số điện thoại không đúng.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Thử lại", style: .cancel, handler: { (UIAlertAction) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                
                present(alert, animated: true, completion: nil)
                return
                
            }
            
        }
        
        if province == ""{
            
            let alert = UIAlertController(title: "Cảnh báo!!", message: "Hãy điền Tỉnh/Thành phố", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Thử lại", style: .cancel, handler: { (UIAlertAction) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            present(alert, animated: true, completion: nil)
            return
            
        }
        
        if district == ""{
            
            let alert = UIAlertController(title: "Cảnh báo!!", message: "Hãy điền Quận/Huyện", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Thử lại", style: .cancel, handler: { (UIAlertAction) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            present(alert, animated: true, completion: nil)
            return
            
        }
        
        if ward == ""{
            
            let alert = UIAlertController(title: "Cảnh báo!!", message: "Hãy điền Phường/Xã", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Thử lại", style: .cancel, handler: { (UIAlertAction) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            present(alert, animated: true, completion: nil)
            return
            
        }
        
        if detailAddressTF.text == ""{
            
            let alert = UIAlertController(title: "Cảnh báo!!", message: "Hãy điền Địa chỉ cụ thể", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Thử lại", style: .cancel, handler: { (UIAlertAction) in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            present(alert, animated: true, completion: nil)
            return
            
        }
        
        
        // thong tin da duoc dien day du
        
        let address = AddressProfile(name: nameTF.text ?? "", phone: phoneTF.text ?? "", province: provinceValueLb.text ?? "", district: districtValueLb.text ?? "", ward: wardValueLb.text ?? "", detailAddress: detailAddressTF.text ?? "", isDefault: "")
        
        
        
        AddressProfileUtils.sentAddressProfileToFirebase(IDUser: userID, addressProfile: address, isDefault: isDefaultSw.isOn, AddressID: addressID)
        
        print("sent back ID: \(userID)")
        
        prevVC.IDUser = userID
        
        prevVC.showSpinner(onView: prevVC.view)
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc func provinceAct(){
        
        
        let vc = PickDataAddressViewController()
        vc.province = DiaChiUtils.listProvince
        vc.type = "province"
        vc.prevVC = self
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav , animated: true, completion: nil)
        
    }
    
    @objc func districtAct(){
        
        if provinceID >= 0{
            
            var list = [AddressDistrict]()
            
            for item in DiaChiUtils.listDistrict{
                
                if item.idProvince == provinceID{
                    
                    list.append(item)
                    
                }
                
            }
            
            let vc = PickDataAddressViewController()
            vc.district = list
            vc.type = "district"
            vc.prevVC = self
            
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            
            present(nav , animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "Cảnh báo", message: "Hãy điền Tỉnh/Thành phố trước", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
                alert.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    @objc func wardAct(){
        
        if districtID >= 0{
            
            var list = [AddressWard]()
            
            for item in DiaChiUtils.listWard{
                
                if item.idDistrict == districtID{
                    
                    list.append(item)
                    
                }
                
            }
            
            let vc = PickDataAddressViewController()
            vc.ward = list
            vc.type = "ward"
            vc.prevVC = self
            
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            
            present(nav , animated: true, completion: nil)
            
        }else{
            
            let alert = UIAlertController(title: "Cảnh báo", message: "Hãy điền Quận/Huyện trước", preferredStyle: .alert)
            present(alert, animated: true, completion: nil)
            
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
                alert.dismiss(animated: true, completion: nil)
            }
            
            
        }
        
    }
    
    @objc func deleteAct(){
        
        UIView.animate(withDuration: 0.1,
            animations: {
                self.deleteBt.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.1) {
                    self.deleteBt.transform = CGAffineTransform.identity
                }
            })
        
        if isEnable {
            
            let alert = UIAlertController(title: "Thông báo", message: "Không thể xoá địa chỉ mặc định", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Đóng", style: .cancel, handler: { (_) in
                alert.dismiss(animated: true, completion: nil)
            }))
            present(alert, animated: true, completion: nil)
            
        }else{
            
            AddressProfileUtils.removeAddressFromFirebase(addressID: addressID)
            prevVC.showSpinner(onView: prevVC.view)
            dismiss(animated: true, completion: nil)
            
        }
        
    }

    
    // MARK: - utility Function
    
    func removeSpinerCheck(){
        
        removeSpinner = removeSpinner + 1
        
        if removeSpinner == 3{
            self.removeSpinner()
        }
        
    }
    
    func ValidationPhoneNumber(_ phone:String?) -> Bool {
        var result = false
        if phone != nil{
            // chú ý --> (0)+(3|5|7|8|9)+([0-9]{8}) khác LoginViewController
            let PHONE_REGEX = "^(0)+(3|5|7|8|9)+([0-9]{8})$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
            result =  phoneTest.evaluate(with: phone)
        }
        return result
    }
    
}
