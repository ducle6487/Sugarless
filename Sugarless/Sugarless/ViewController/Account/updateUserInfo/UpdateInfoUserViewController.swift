//
//  UpdateInfoUserViewController.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 11/01/2021.
//

import UIKit

class UpdateInfoUserViewController: UIViewController {

    // MARK: - Variaable
    
    private var index = 0
    
    var firstUpdate = false
    
    var backBt = UIButton(type: .custom)
    
    var userInfo : ProfileUser?
    
    var userImageImg = UIImageView()
    
    var toolbarGender = UIToolbar()
    
    var toolbarBirthDay = UIToolbar()
    
    var birthDayPickerVw = UIDatePicker()
    
    let coverVw = UIView()
    
    var genderPickerVw = UIPickerView()
    
    private let genderData = ["" , "Nam", "Nữ", "LGBT"]
    
    var nameVw = UIView()
    var genderVw = UIView()
    var birthDayVw = UIView()
    var phoneVw = UIView()
    var desVw = UIView()
    
    let nameValueLb = UILabel()
    let genderValue = UILabel()
    let birthdayValueLb = UILabel()
    let phoneValue = UILabel()
    let desValueLb = UILabel()
    
    var name = ""
    var gender = ""
    var birthDay = ""
    var phone = ""
    var des = ""
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Profile"
        
        // nút back trong navigation Bar
        
    
        backBt.setImage(UIImage(named: "back"), for: .normal)
        backBt.setTitle(" Back", for: .normal)
        backBt.setTitleColor(backBt.tintColor, for: .normal)
        backBt.addTarget(self, action: #selector(backAct), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBt)
    
        genderPickerVw.delegate = self
        genderPickerVw.dataSource = self
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAct))
        // setup UI
        
        setupUI()
        
        
    }
    
    // MARK: - setup UI Function
    
    func setupUI(){
        
        self.view.addSubview(userImageImg)
        userImageImg.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(self.view.frame.height / 15)
            make.height.width.equalTo(self.view.snp.height).dividedBy(5)
            make.centerX.equalToSuperview()
        }
        
        
        
        if userInfo?.imageUrl != nil{

            userImageImg.downloaded(from: URL(string: userInfo!.imageUrl!)!)
            userImageImg.contentMode = .scaleAspectFit
            userImageImg.layer.cornerRadius = self.view.frame.height / 10
            userImageImg.clipsToBounds = true

        }
        
        
        //ben trong name view
        
        name = userInfo?.displayName ?? ""
        
        let nameLb = UILabel()
        
        let arrow1 = UIImageView()
        
        
        self.view.addSubview(nameVw)
        nameVw.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(-1)
            make.trailing.equalToSuperview().offset(1)
            make.top.equalTo(userImageImg.snp.bottom).offset(self.view.frame.height / 15)
            make.height.equalToSuperview().dividedBy(15)
        }
        
        
        nameVw.layer.borderWidth = 0.5
        nameVw.layer.borderColor = UIColor.init(white: 0.6, alpha: 1).cgColor
        
        
        nameVw.addSubview(nameLb)
        nameLb.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.view.frame.width / 20)
            make.centerY.equalToSuperview()
        }
        
        nameLb.text = "Tên"
        nameLb.font = .systemFont(ofSize: 20, weight: .semibold)
        
        
        nameVw.addSubview(arrow1)
        arrow1.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-(self.view.frame.width / 25))
            make.centerY.equalToSuperview()
        }
        
        arrow1.image = UIImage(named: "backBlack")
        arrow1.transform = CGAffineTransform(rotationAngle: .pi)
        
        nameVw.addSubview(nameValueLb)
        nameValueLb.snp.makeConstraints { (make) in
            make.trailing.equalTo(arrow1.snp.leading).offset(-(self.view.frame.width / 30))
            make.centerY.equalToSuperview()
            
        }
        
        
        nameValueLb.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        if name != ""{
            
            nameValueLb.text = userInfo?.displayName!
            nameValueLb.textColor = .black
            
        }else{
            
            nameValueLb.text = "Thiết lập ngay"
            nameValueLb.textColor = .systemRed
            
        }
        
        
        //ben trong gender view
        
        gender = userInfo?.gioiTinh ?? ""
        
        let genderLb = UILabel()
        
        let arrow2 = UIImageView()
        
        self.view.addSubview(genderVw)
        genderVw.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(nameVw)
            make.top.equalTo(nameVw.snp.bottom).offset(-0.5)
        }
        
        genderVw.layer.borderWidth = 0.5
        genderVw.layer.borderColor = UIColor.init(white: 0.6, alpha: 1).cgColor
        
        
        
        genderVw.addSubview(genderLb)
        genderLb.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLb)
            make.centerY.equalToSuperview()
        }
        
        genderLb.text = "Giới tính"
        genderLb.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        
        genderVw.addSubview(arrow2)
        arrow2.snp.makeConstraints { (make) in
            make.trailing.height.width.equalTo(arrow1)
            make.centerY.equalToSuperview()
        }
        
        arrow2.image = UIImage(named: "backBlack")
        arrow2.transform = CGAffineTransform.init(rotationAngle: .pi)
        
        genderVw.addSubview(genderValue)
        genderValue.snp.makeConstraints { (make) in
            make.trailing.equalTo(nameValueLb)
            make.centerY.equalToSuperview()
        }
        
        
        genderValue.font = .systemFont(ofSize: 15, weight: .medium)
        
        if gender != ""{
            
            genderValue.text = gender
            genderValue.textColor = .black
            
        }else{
            
            genderValue.text = "Thiết lập ngay"
            genderValue.textColor = .systemRed
            
        }
        
        //ben trong birth day view
        
        birthDay = userInfo?.birthDay ?? ""
        
        let birthdayLb = UILabel()
        
        let arrow3 = UIImageView()
        
        
        self.view.addSubview(birthDayVw)
        birthDayVw.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(nameVw)
            make.top.equalTo(genderVw.snp.bottom).offset(-0.5)
        }
        
        
        birthDayVw.layer.borderWidth = 0.5
        birthDayVw.layer.borderColor = UIColor.init(white: 0.6, alpha: 1).cgColor
        
        
        birthDayVw.addSubview(birthdayLb)
        birthdayLb.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLb)
            make.centerY.equalToSuperview()
        }
        
        birthdayLb.text = "Ngày sinh"
        birthdayLb.font = .systemFont(ofSize: 20, weight: .semibold)
        
        
        birthDayVw.addSubview(arrow3)
        arrow3.snp.makeConstraints { (make) in
            make.trailing.height.width.equalTo(arrow1)
            make.centerY.equalToSuperview()
        }
        
        
        arrow3.image = UIImage(named: "backBlack")
        arrow3.transform = CGAffineTransform(rotationAngle: .pi)
        
        
        birthDayVw.addSubview(birthdayValueLb)
        birthdayValueLb.snp.makeConstraints { (make) in
            make.trailing.equalTo(nameValueLb)
            make.centerY.equalToSuperview()
        }
        
        
        birthdayValueLb.font = .systemFont(ofSize: 15, weight: .medium)
        
        if birthDay != ""{
            
            birthdayValueLb.text = birthDay
            birthdayValueLb.textColor = .black
            
        }else{
            
            birthdayValueLb.text = "Thiết lập ngay"
            birthdayValueLb.textColor = .systemRed
            
        }
        
        
        //ben trong phone view
        
        
        phone = userInfo?.phone ?? ""
        let phoneLb = UILabel()
        
        let arrow4 = UIImageView()
        
        
        
        self.view.addSubview(phoneVw)
        phoneVw.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(nameVw)
            make.top.equalTo(birthDayVw.snp.bottom).offset(-0.5)
        }
        
        phoneVw.layer.borderWidth = 0.5
        phoneVw.layer.borderColor = UIColor.init(white: 0.6, alpha: 1).cgColor
        
        
        phoneVw.addSubview(phoneLb)
        phoneLb.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLb)
            make.centerY.equalToSuperview()
        }
        
        phoneLb.text = "Số điện thoại"
        phoneLb.font = .systemFont(ofSize: 20, weight: .semibold)
        
        
        phoneVw.addSubview(arrow4)
        arrow4.snp.makeConstraints { (make) in
            make.trailing.width.height.equalTo(arrow1)
            make.centerY.equalToSuperview()
        }
        
        arrow4.image = UIImage(named: "backBlack")
        arrow4.transform = CGAffineTransform(rotationAngle: .pi)
        
        
        phoneVw.addSubview(phoneValue)
        phoneValue.snp.makeConstraints { (make) in
            make.trailing.equalTo(nameValueLb)
            make.centerY.equalToSuperview()
        }
        
        phoneValue.font = .systemFont(ofSize: 15, weight: .medium)
        
        if phone != ""{
            
            phoneValue.text = phone
            phoneValue.textColor = .black
            
        }else{
            
            phoneValue.text = "Thiết lập ngay"
            phoneValue.textColor = .systemRed
            
        }
        
        //ben trong des view
        
        des = userInfo?.descriptionUser ?? ""
        
        let desLb = UILabel()
        
        let arrow5 = UIImageView()
        
        self.view.addSubview(desVw)
        desVw.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(nameVw)
            make.top.equalTo(phoneVw.snp.bottom).offset(-0.5)
        }
        
        desVw.layer.borderWidth = 0.5
        desVw.layer.borderColor = UIColor.init(white: 0.6, alpha: 1).cgColor
        
        desVw.addSubview(desLb)
        desLb.snp.makeConstraints { (make) in
            make.leading.equalTo(nameLb)
            make.centerY.equalToSuperview()
        }
        
        desLb.text = "Description"
        desLb.font = .systemFont(ofSize: 20, weight: .semibold)
        
        
        desVw.addSubview(arrow5)
        arrow5.snp.makeConstraints { (make) in
            make.trailing.height.width.equalTo(arrow1)
            make.centerY.equalToSuperview()
        }
        
        arrow5.image = UIImage(named: "backBlack")
        arrow5.transform = CGAffineTransform(rotationAngle: .pi)
        
        
        desVw.addSubview(desValueLb)
        desValueLb.snp.makeConstraints { (make) in
            make.trailing.equalTo(nameValueLb)
            make.leading.equalTo(self.view.snp.centerX)
            make.centerY.equalToSuperview()
        }
        
        desValueLb.textAlignment = .right
        desValueLb.font = .systemFont(ofSize: 15, weight: .medium)
        
        if des != ""{
            
            desValueLb.text = des
            desValueLb.textColor = .black
            
        }else{
            
            desValueLb.text = "Thiết lập ngay"
            desValueLb.textColor = .systemRed
            
        }
        
        
        nameVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nameAct)))
        
        genderVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(genderAct)))
        
        birthDayVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(birthDayAct)))
        
        phoneVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(phoneAct)))
        
        desVw.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(desAct)))
        
        
        
        
        
        self.view.addSubview(coverVw)
        coverVw.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        coverVw.addSubview(toolbarGender)
        toolbarGender.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
            make.top.equalTo(self.view.snp.centerY).offset(self.view.frame.height / 7)
        }
        
        toolbarGender.sizeToFit()

        let done1 = UIBarButtonItem(title: "Đồng Ý", style: .done, target: self, action: #selector(genderDoneAct))
        let space1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel1 = UIBarButtonItem(title: "Hủy", style: .plain, target: self, action: #selector(genderCancelAct))
        toolbarGender.setItems([cancel1, space1, done1], animated: false)
        
        coverVw.addSubview(genderPickerVw)
        genderPickerVw.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(toolbarGender.snp.bottom)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        genderPickerVw.backgroundColor = .init(white: 0.9, alpha: 1)
        
        isHideDataPickerView(hide: true)
        
        
        coverVw.addSubview(toolbarBirthDay)
        toolbarBirthDay.snp.makeConstraints { (make) in
            make.leading.trailing.height.centerY.equalTo(toolbarGender)
        }
        
        toolbarBirthDay.sizeToFit()
        
        let done2 = UIBarButtonItem(title: "Đồng Ý", style: .done, target: self, action: #selector(birthDayDoneAct))
        let space2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel2 = UIBarButtonItem(title: "Hủy", style: .plain, target: self, action: #selector(birthDayCancelAct))
        toolbarBirthDay.setItems([cancel2, space2, done2], animated: false)
        
        coverVw.addSubview(birthDayPickerVw)
        birthDayPickerVw.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(genderPickerVw)
        }
        
        birthDayPickerVw.datePickerMode = .date
        let loc = Locale(identifier: "vi")
        birthDayPickerVw.locale = loc
        if #available(iOS 14.0, *) {
            birthDayPickerVw.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        birthDayPickerVw.backgroundColor = .init(white: 0.9, alpha: 1)
        let currentDate = Date()
        var dateComponents = DateComponents()
        let calendar = Calendar.init(identifier: .gregorian)
        dateComponents.year = -100
        let minDate = calendar.date(byAdding: dateComponents, to: currentDate)
        dateComponents.year = 0
        let maxDate = calendar.date(byAdding: dateComponents, to: currentDate)
        
        birthDayPickerVw.maximumDate = maxDate
        birthDayPickerVw.minimumDate = minDate
        
        isHideDatePickerView(hide: true)
        
    }
    
    

    // MARK: - Action Function
    
    @objc func backAct(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc func saveAct(){
        
        let profile = ProfileUser(id: userInfo?.ID ?? "", name: name, img: userInfo?.imageUrl ?? "", des: des, email: userInfo?.email ?? "", ns: birthDay, gioitinh: gender, phone: phone)
        ProfileUtils.installProfile(profile: profile)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc func nameAct(){
        
        let vc = SetDataUserViewController()
        
        vc.navTitle = "Tên"
        vc.placeHolder = "Nhập tên..."
        vc.typeData = "name"
        vc.dataTf.text = name
        vc.prevVC = self
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .crossDissolve
        
        
        present(nav, animated: true, completion: nil)
        
        
    }
    
    @objc func genderAct(){
        
        isHideDataPickerView(hide: false)
        
    }
    
    @objc func birthDayAct(){
        
        
        isHideDatePickerView(hide: false)
        
    }
    
    @objc func phoneAct(){
        
        let vc = SetDataUserViewController()
        
        vc.navTitle = "Số điện thoại"
        vc.placeHolder = "Nhập số điện thoại..."
        vc.typeData = "phone"
        vc.dataTf.text = phone
        vc.dataTf.keyboardType = .phonePad
        vc.prevVC = self
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .crossDissolve
        
        
        present(nav, animated: true, completion: nil)
        
    }
    
    @objc func desAct(){
        
        let vc = SetDataUserViewController()
        
        vc.navTitle = "Description"
        vc.placeHolder = "Nhập Description..."
        vc.typeData = "des"
        vc.dataTf.text = des
        vc.prevVC = self
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .crossDissolve
        
        
        present(nav, animated: true, completion: nil)
        
    }
    
    @objc func genderDoneAct(){
        
        if index == 0{
            genderValue.text = "Thiết lập ngay"
            genderValue.textColor = .systemRed
            gender = ""
        }else{
            genderValue.text = genderData[index]
            genderValue.textColor = .black
            gender = genderData[index]
        }
        
        
        
        index = 0
        
        isHideDataPickerView(hide: true)
        
    }
    
    @objc func genderCancelAct(){
        
        if gender == ""{
            genderValue.text = "Thiết lập ngay"
            genderValue.textColor = .systemRed
        }else{
            genderValue.text = gender
            genderValue.textColor = .black
        }
        
        
        index = 0
        isHideDataPickerView(hide: true)
    }
    
    
    @objc func birthDayDoneAct(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        birthdayValueLb.text = formatter.string(from: birthDayPickerVw.date)
        birthDay = formatter.string(from: birthDayPickerVw.date)
        birthdayValueLb.textColor = .black
        isHideDatePickerView(hide: true)
        
    }
    
    
    @objc func birthDayCancelAct(){
        
        if birthDay == ""{
            
            birthdayValueLb.text = "Thiết lập ngay"
            birthdayValueLb.textColor = .systemRed
            
        }else{
            
            birthdayValueLb.text = birthDay
            birthdayValueLb.textColor = .black
            
        }
        
        
        
        
        isHideDatePickerView(hide: true)
        
        
    }
    
    // MARK: - Utility Function
    
    
    func isHideDataPickerView(hide: Bool){
        
        coverVw.isHidden = hide
        genderPickerVw.isHidden = hide
        toolbarGender.isHidden = hide
        
    }
    
    func isHideDatePickerView(hide: Bool){
        
        coverVw.isHidden = hide
        birthDayPickerVw.isHidden = hide
        toolbarBirthDay.isHidden = hide
        
    }
    
    
    
}


// MARK: - PickerView delegate and datasource
extension UpdateInfoUserViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return genderData.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        index = row
//        genderValue.text = genderData[row]
        
    }
    
}


