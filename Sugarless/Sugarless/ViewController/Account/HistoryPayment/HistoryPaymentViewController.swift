//
//  HistoryPaymentViewController.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 22/01/2021.
//

import UIKit
import FirebaseAuth

class HistoryPaymentViewController: UIViewController, sentAddressProfileNeverDeleteToUI {
    
    // MARK: - Protocol Function
    
    func onDataUpdate() {
        
        for item in PaymentUtils.listPayment{
//            print("\(item.addressID) item")
            for i in AddressProfileUtils.listAddressNoDelete{
//                print("\(i.isDefault) i")
                if item.addressID! == i.isDefault!{
                    dataAddressPayment.append(i)
                }
                
            }
            
        }
        print(dataAddressPayment.count)
        tableView.reloadData()
        self.removeSpinner()
    }
    

    // MARK: - Variable
    
    fileprivate let cellID = "historyCell"
    
    lazy var tableView : UITableView = {
        
        let vc = UITableView(frame: .zero)
        
        vc.delegate = self
        vc.dataSource = self
        
        return vc
        
    }()
    
    var dataAddressPayment = [AddressProfile]()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back"), for: .normal) // Image can be downloaded from here below link
        backbutton.setTitle(" Back", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal) // You can change the TitleColor
        backbutton.addTarget(self, action: #selector(dismissAct), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        
        self.showSpinner(onView: self.view)
        
        AddressProfileUtils.getAddressUndeleteProfileFromFirebase(ID: Auth.auth().currentUser!.uid)
        AddressProfileUtils.delegateNeverDelete = self
        
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Lịch sử mua hàng"
        
        
        tableView.register(HistoryPaymentTableViewCell.self, forCellReuseIdentifier: cellID)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
    }
    
    
    // MARK: - Action Function

    
    @objc func dismissAct(){
        
        dismiss(animated: true, completion: nil)
        
    }

}

extension HistoryPaymentViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PaymentUtils.listPayment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! HistoryPaymentTableViewCell
        if !dataAddressPayment.isEmpty{
            cell.setupCell()
            cell.dataAddress = dataAddressPayment[indexPath.row]
            cell.dataPayment = PaymentUtils.listPayment[indexPath.row]
            cell.selectionStyle = .none
            cell.updateAddress()
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(self.view.frame.height / 5)
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if !dataAddressPayment.isEmpty{
            
            let vc = ItemInPaymentViewController()
            vc.listItemPayment = PaymentUtils.listPayment[indexPath.row].listItem!
            vc.totalPriceCart = Int(PaymentUtils.listPayment[indexPath.row].totalCartPayment!) ?? 0
            
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            
            present(nav, animated: true, completion: nil)
            
        }
        
    }
    
}
