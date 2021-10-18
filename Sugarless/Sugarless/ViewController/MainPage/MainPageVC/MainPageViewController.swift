//
//  MainPageViewController.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 23/12/2020.
//

import UIKit
import GoogleSignIn
import SnapKit
import FirebaseAuth
import FBSDKLoginKit

class MainPageViewController: UIViewController{
    
    
    

    // MARK: - Variable
    var count = 0
    
    var rootVC = UITabBarController()
    
    lazy var mainPageCLV: MainPageCollectionView = {
       
        let vc = MainPageCollectionView()
        vc.mainPageVC = self
        return vc
        
    }()
    
    let monanUtils = MonAnUtils()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        self.showSpinner(onView: self.view)
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Shop"
        self.hideKeyboardWhenTappedAround()
        
        
        checkAuth()
        
        setupUI()
        
//        signOut()
     
        PaymentUtils.getPaymentFromFirebase()
        
    }
    
    // MARK: - handle Upload Profile to firebase
    
    
    
    
    
    // MARK: - SetupUI
    
    func checkAuth(){
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let vc = LoginViewController()
                vc.modalPresentationStyle = .fullScreen
                self.rootVC.present(vc, animated: true, completion: nil)
            }
        }else{
            
        }
    }
    
    
    func setupUI(){
        
        
        
        self.view.addSubview(mainPageCLV)
        mainPageCLV.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        
    }
    
    
    // MARK: - Action Function
    
    @objc func signOut(){
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
   
    
    // MARK: - Search Bar Delegate Datasource
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        
    }
    
    
    

}
