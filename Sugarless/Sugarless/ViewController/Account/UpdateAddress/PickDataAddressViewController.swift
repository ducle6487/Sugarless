//
//  PickDataAddressViewController.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 18/01/2021.
//

import UIKit

class PickDataAddressViewController: UIViewController {

    // MARK: -variable
    
    fileprivate let cellid = "pickDataCell"
    
    var prevVC = SetDataAddressViewController()
    
    var type = ""
    var province = [AddressProvince]()
    var district = [AddressDistrict]()
    var ward = [AddressWard]()
    
    lazy var tableView : UITableView = {
       
        let vc = UITableView(frame: .zero)
        vc.delegate = self
        vc.dataSource = self
        return vc
        
    }()
    
    
    // MARK: - Life cycle
    
    
    
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

        tableView.register(PickDataAddressTableViewCell.self, forCellReuseIdentifier: cellid)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
    }
    

    // MARK: - action Function
    
    @objc func dismissAct(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    

}

// MARK: - extension tableview

extension PickDataAddressViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == "province"{
            return province.count
        }else if type == "district"{
            return district.count
        }else if type == "ward"{
            return ward.count
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! PickDataAddressTableViewCell
        
        if type == "province"{
            cell.setupCell(name: province[indexPath.row].nameProvince ?? "")
        }else if type == "district"{
            cell.setupCell(name: district[indexPath.row].nameDistrict ?? "")
        }else if type == "ward"{
            cell.setupCell(name: ward[indexPath.row].nameWard ?? "")
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height / 17
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if type == "province"{
            prevVC.provinceValueLb.text = province[indexPath.row].nameProvince
            prevVC.provinceValueLb.textColor = .black
            prevVC.provinceID = province[indexPath.row].idProvince!
            prevVC.districtValueLb.textColor = UIColor.init(white: 0.75, alpha: 1)
            prevVC.districtValueLb.text = "Điền Quận/Huyện"
            prevVC.districtID = -1
            prevVC.wardValueLb.text = "Điền Phường/Xã"
            prevVC.wardValueLb.textColor = UIColor.init(white: 0.75, alpha: 1)
            prevVC.province = province[indexPath.row].nameProvince!
            prevVC.district = ""
            prevVC.ward = ""
        }else if type == "district"{
            prevVC.districtValueLb.text = district[indexPath.row].nameDistrict
            prevVC.districtValueLb.textColor = .black
            prevVC.districtID = district[indexPath.row].idDistrict!
            prevVC.wardValueLb.text = "Điền Phường/Xã"
            prevVC.wardValueLb.textColor = UIColor.init(white: 0.75, alpha: 1)
            prevVC.district = district[indexPath.row].nameDistrict!
            prevVC.ward = ""
        }else if type == "ward"{
            prevVC.wardValueLb.text = ward[indexPath.row].nameWard
            prevVC.wardValueLb.textColor = .black
            prevVC.ward = ward[indexPath.row].nameWard!
        }
        
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    // MARK: - utility function
    
    
    
    
}
