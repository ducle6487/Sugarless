//
//  UpdateAddressViewController.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 18/01/2021.
//

import UIKit
import SnapKit

class UpdateAddressViewController: UIViewController, sentAddressProfileToUI, sentDefaultAddressToUI, reloadDataAddress {
    
    // MARK: - protocol
    
    
    
    func upLoadAddressDefault(IDUser: String, IDAddress: String, isDefault: Bool) {
        AddressProfileUtils.sentDefaultAddressToFirebase(IDUser: IDUser, IDAddress: IDAddress,isDefault: isDefault)
    }
    
   
    func reload() {
        AddressProfileUtils.getAddressProfileFromFirebase(ID: IDUser)
    }
    
    
    func deleting() {
        AddressProfileUtils.getAddressProfileFromFirebase(ID: IDUser)
    }
    
    
    func sending() {
        
            
        if AddressProfileUtils.AddressDefault ?? "" != ""{
            addressDefaultID = AddressProfileUtils.AddressDefault!
            self.tableView.reloadData()
            
        }
            
        self.removeSpinner()
            
        
    }
    
    
    func onDataUpdate() {
        
        DispatchQueue.main.async {
            self.listAddress = AddressProfileUtils.listAddress
            print("listAddress: \(self.listAddress.count)")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            AddressProfileUtils.getAddressDefaultFromFirebase()
        }
        
    }
    

    // MARK: - variable
    
    var typePresent = ""
    
    var prevVC = DeliveryDescriptionViewController()
    
    fileprivate let cellid = "addressCell"
    
    var IDUser = ""
    
    var addressDefaultID = ""
    
    var listAddress = [AddressProfile]()
    
    lazy var tableView : UITableView = {
       
        let vc = UITableView(frame: .zero, style: .plain)
        
        vc.delegate = self
        vc.dataSource = self
        
        
        
        return vc
        
    }()
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back"), for: .normal) // Image can be downloaded from here below link
        backbutton.setTitle(" Back", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal) // You can change the TitleColor
        backbutton.addTarget(self, action: #selector(dismissAct), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Địa chỉ"
        
        self.showSpinner(onView: self.view)
        
        if typePresent == ""{
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAct))
        }
        
        tableView.register(UpdateAddressTableViewCell.self, forCellReuseIdentifier: cellid)
        
        tableView.backgroundColor = .init(white: 0.9, alpha: 1)
        
        AddressProfileUtils.delegateDefault = self
        AddressProfileUtils.delegate = self
        AddressProfileUtils.delegateReload = self
        AddressProfileUtils.getAddressProfileFromFirebase(ID: IDUser)
        
        
        
        setupUI()
        
    }
    
    // MARK: - set up UI
    
    
    func setupUI(){
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
    }
    

    // MARK: - action Function
    
    @objc func dismissAct(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func addAct(){
        
        let vc = SetDataAddressViewController()
        vc.userID = IDUser
        vc.isAdd = true
        
        if AddressProfileUtils.listAddress.isEmpty{
            
            vc.isEnable = true
            
        }
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true, completion: nil)
        
    }
    
    
    
    
    
    // MARK: - Utility Function
    
    func presentWithData(name: String, phone: String, detail: String, ward: String, district: String, province: String, isDefault: Bool, addressID: String){
        
        let vc = SetDataAddressViewController()
        vc.prevVC = self
        vc.modalPresentationStyle = .fullScreen
        
        vc.name = name
        vc.phone = phone
        vc.detail = detail
        vc.ward = ward
        vc.district = district
        vc.province = province
        vc.isEnable = isDefault
        vc.addressID = addressID
        vc.userID = IDUser
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
        
    }
    
    
}

// MARK: - extension

extension UpdateAddressViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! UpdateAddressTableViewCell
        cell.selectionStyle = .none
        
        var tempBool = false
        
        if listAddress[indexPath.item].isDefault == addressDefaultID{
            
            tempBool = true
            
        }
        
        cell.setupCell(name: listAddress[indexPath.item].name ?? "", phone: listAddress[indexPath.item].phone ?? "", detail: listAddress[indexPath.item].detailAddress ?? "" , ward: listAddress[indexPath.item].ward ?? "", district: listAddress[indexPath.item].district ?? "", province: listAddress[indexPath.item].province ?? "", isDefault: tempBool)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.view.frame.height / 6)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(15)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if typePresent == ""{
            var tempBool = false
            
            if listAddress[indexPath.item].isDefault == addressDefaultID{
                
                tempBool = true
                
            }
            
            let data = listAddress[indexPath.row]
            
            presentWithData(name: data.name ?? "", phone: data.phone ?? "", detail: data.detailAddress ?? "", ward: data.ward ?? "" , district: data.district ?? "", province: data.province ?? "", isDefault: tempBool, addressID: data.isDefault ?? "")
        }else{
            
            prevVC.dataAddress = listAddress[indexPath.row]
            prevVC.updateAddress()
            dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    
}
