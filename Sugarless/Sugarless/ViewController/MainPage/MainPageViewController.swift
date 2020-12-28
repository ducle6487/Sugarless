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

class MainPageViewController: UIViewController {

    
    var logout = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let vc = LoginViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }else{
            print(Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email)
        }
        
        self.view.addSubview(logout)
        logout.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.width.equalTo(80)
        }
        
        logout.setAttributedTitle(NSAttributedString(string: "out"), for: .normal)
        logout.addTarget(self, action: #selector(signOut), for: .touchUpInside)
    }
    
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
   

}
