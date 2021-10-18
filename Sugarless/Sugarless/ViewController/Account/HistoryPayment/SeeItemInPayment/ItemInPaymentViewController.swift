//
//  ItemInPaymentViewController.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 22/01/2021.
//

import UIKit

class ItemInPaymentViewController: UIViewController {

    // MARK: - Variable
    
    fileprivate var cellid = "ItemPayment"
    
    var totalPriceCart = 0
    
    var listItemPayment = [GioHang]()
    
    lazy var tableView : UITableView = {
       
        let vc = UITableView(frame: self.view.frame)
        
        vc.showsVerticalScrollIndicator = false
        
        vc.delegate = self
        vc.dataSource = self
        
        return vc
        
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        let backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back"), for: .normal) // Image can be downloaded from here below link
        backbutton.setTitle(" Back", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal) // You can change the TitleColor
        backbutton.addTarget(self, action: #selector(dismissAct), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Tổng giá trị: \(totalPriceCart.formattedWithSeparator)"
        
        tableView.register(ItemInPaymentTableViewCell.self, forCellReuseIdentifier: cellid)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        print(listItemPayment.count)
    }
    
    
    // MARK: - Action Function
    
    @objc func dismissAct(){
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    

    
}

extension ItemInPaymentViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItemPayment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid) as! ItemInPaymentTableViewCell
        cell.setupView(name: listItemPayment[indexPath.item].name ?? "", image: listItemPayment[indexPath.item].image ?? "", amount: listItemPayment[indexPath.item].amount ?? 0, price: listItemPayment[indexPath.item].price ?? "")
        cell.selectionStyle = .none
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return CGFloat(self.view.frame.height / 6)
        
    }
    
}
