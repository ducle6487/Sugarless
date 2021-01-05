//
//  DescriptionViewController.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 29/12/2020.
//

import UIKit

class CustomSeeAllViewController: UIViewController {

    // MARK: - Variable
    
    
    var listMonAn = [MonAn]()
    
    
    
    var navTitle : String?
    
    lazy var bestSellerCLV : CustomAllProductCollectionView = {
        
        let vc = CustomAllProductCollectionView()
        vc.seeAllVC = self
        vc.listMonAn = listMonAn
        
        return vc
        
    }()
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back"), for: .normal) // Image can be downloaded from here below link
        backbutton.setTitle(" Back", for: .normal)
        backbutton.setTitleColor(backbutton.tintColor, for: .normal) // You can change the TitleColor
        backbutton.addTarget(self, action: #selector(dismissAct), for: .touchUpInside)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        
        self.view.backgroundColor = .white
        
        
        self.navigationItem.title = navTitle
        
        bestSeller()
        
    }
    
    
    // MARK: - Setup UI
    
    func bestSeller(){
        
        self.view.addSubview(bestSellerCLV)
        bestSellerCLV.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        
    }
    
    
   
    
    // MARK: - Action Function
    
    @objc func dismissAct(){
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
}
