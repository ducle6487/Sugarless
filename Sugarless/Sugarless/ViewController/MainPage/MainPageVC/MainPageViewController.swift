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

class MainPageViewController: UIViewController, UISearchBarDelegate {

    // MARK: - Variable
    
    var searchBar = UISearchBar()
    
    lazy var mainPageCLV: MainPageCollectionView = {
       
        let vc = MainPageCollectionView()
        vc.mainPageVC = self
        return vc
        
    }()
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Shop"
        self.hideKeyboardWhenTappedAround()
        
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let vc = LoginViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }else{
            print(Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email)
        }
        
        setupUI()
        
        
    }
    
    
    // MARK: - SetupUI
    
    func setupUI(){
        
        self.view.addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.view.frame.width / 20)
            make.trailing.equalToSuperview().offset(-(self.view.frame.width / 20))
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(self.view.frame.height / 30)
        }
        
        searchBar.searchBarStyle = .minimal
        searchBar.isTranslucent = false
        searchBar.placeholder = "Search store"
     
        
        self.view.addSubview(mainPageCLV)
        mainPageCLV.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
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
