//
//  ViewController.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 21/12/2020.
//

import UIKit
import SnapKit
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit

class LoginViewController: UIViewController {

    // MARK: - Variable
    
    var emailLB = UILabel()
    var passLB = UILabel()
    var emailTF = UITextField()
    var passTF = UITextField()
    var backImg = UIImageView()
    var socialLb = UILabel()
    var registerLb = UILabel()
    var registerBt = UIButton()
    
    let line1 = UIView()
    let line2 = UIView()
    
    var loginBt = UIButton()
    
    var loginGoogleBt = UIButton()
    
    var loginFacebookBt = UIButton()
    
    var showPass = false
    
    let loginManager = LoginManager()
    
    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the
        
        setupUI()
        
        view.backgroundColor = UIColor.rgb(red: 252, green: 252, blue: 252, a: 1)
        self.hideKeyboardWhenTappedAround()
        
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
    }

    // MARK: - login Facebook funtion
    
    
    func loginButton(_ loginButton: FBLoginButton!, didCompleteWith result: LoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
        return
        }
        if( AccessToken.current != nil ){
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    print("Facebook authentication with Firebase error: ", error)
                    return
                }
            print("Login success!")
                self.dismiss(animated: true, completion: nil)
                
            }
        }
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton!) {
        print("Logged out")
    }
    
    // MARK: - User Interface
    
    func setupUI(){
        
        self.view.addSubview(backImg)
        backImg.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(2)
            make.height.equalToSuperview().dividedBy(1.75)
            make.top.equalToSuperview().offset(-(self.view.frame.width / 5))
            make.centerX.equalToSuperview().offset(self.view.frame.width / 8)
        }
        
        backImg.image = UIImage(named: "backLogin")
        backImg.transform = backImg.transform.rotated(by: .pi * 1.25)
        
        self.view.addSubview(emailLB)
        emailLB.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.view.frame.width / 17)
            make.top.equalToSuperview().offset((self.view.frame.height / 2.5))
            
        }
        
        emailLB.font = UIFont.boldSystemFont(ofSize: 15)
        emailLB.text = "Email"
        
        emailLB.textColor = .gray
        
        self.view.addSubview(emailTF)
        emailTF.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.view.frame.width / 17)
            make.trailing.equalToSuperview().offset(-(self.view.frame.width / 17))
            make.top.equalTo(emailLB.snp.bottom)
            make.height.equalToSuperview().dividedBy(21)
        }
        
        emailTF.textContentType = .emailAddress
        emailTF.placeholder = "Enter your Email"
        
        
        self.view.addSubview(line1)
        line1.snp.makeConstraints { (make) in
            make.top.equalTo(emailTF.snp.bottom)
            make.height.equalTo(1)
            make.width.trailing.equalTo(emailTF)
        }
        line1.backgroundColor = .gray
        line1.alpha = 0.3
        
        self.view.addSubview(passLB)
        passLB.snp.makeConstraints { (make) in
            make.leading.equalTo(emailLB)
            make.top.equalTo(line1.snp.bottom).offset(self.view.frame.height / 30)
        }
        
        passLB.text = "Password"
        passLB.textColor = .gray
        passLB.font = UIFont.boldSystemFont(ofSize: 15)
        
        self.view.addSubview(passTF)
        passTF.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(emailTF)
            make.height.equalTo(emailTF)
            make.top.equalTo(passLB.snp.bottom)
        }
        
        passTF.isSecureTextEntry.toggle()
        passTF.textContentType = .password
        passTF.placeholder = "Enter your Password"
        
        
        
        self.view.addSubview(line2)
        line2.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(emailTF)
            make.height.equalTo(1)
            make.top.equalTo(passTF.snp.bottom)
        }
        line2.backgroundColor = .gray
        line2.alpha = 0.3
        
        self.view.addSubview(loginBt)
        loginBt.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(emailTF)
            make.top.equalTo(line2.snp.bottom).offset(self.view.frame.height / 25)
            make.height.equalToSuperview().dividedBy(14)
        }
        loginBt.backgroundColor = UIColor.init(red: 119/255, green: 186/255, blue: 119/255, alpha: 1)
        loginBt.setAttributedTitle(NSAttributedString(string: "Log In", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22), NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        loginBt.layer.cornerRadius = 20
        
        loginBt.addTarget(self, action: #selector(loginAct), for: .touchUpInside)
        
        self.view.addSubview(socialLb)
        socialLb.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginBt.snp.bottom).offset(self.view.frame.height / 40)
        }
        
        socialLb.text = "Or connect with social media"
        socialLb.font = UIFont.boldSystemFont(ofSize: 13)
        socialLb.textColor = .gray
        
        
        self.view.addSubview(loginGoogleBt)
        loginGoogleBt.snp.makeConstraints { (make) in
            make.height.leading.trailing.equalTo(loginBt)
            make.top.equalTo(socialLb.snp.bottom).offset(self.view.frame.height / 40)
        }
        
        loginGoogleBt.addTarget(self, action: #selector(loginGoogleAct), for: .touchUpInside)
        loginGoogleBt.layer.cornerRadius = 20
        loginGoogleBt.backgroundColor = UIColor.init(red: 234/255, green: 67/255, blue: 53/255, alpha: 1)
        
        let googleLb = UILabel()
        loginGoogleBt.addSubview(googleLb)
        googleLb.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        googleLb.text = "Continue with Google"
        googleLb.font = UIFont.boldSystemFont(ofSize: 18)
        googleLb.textColor = .white
        
        
        let googleImg = UIImageView()
        loginGoogleBt.addSubview(googleImg)
        googleImg.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalTo(googleLb.snp.leading)
            make.height.equalToSuperview().dividedBy(1.6)
            make.centerY.equalToSuperview()
        }
        
        googleImg.image = UIImage.init(named: "google")
        googleImg.contentMode = .scaleAspectFit
        
        
        self.view.addSubview(loginFacebookBt)
        loginFacebookBt.snp.makeConstraints { (make) in
            make.leading.trailing.height.equalTo(loginGoogleBt)
            make.top.equalTo(loginGoogleBt.snp.bottom).offset(self.view.frame.height / 40)
        }
        
        loginFacebookBt.layer.cornerRadius = 20
        loginFacebookBt.backgroundColor = UIColor.init(red: 41/255, green: 82/255, blue: 150/255, alpha: 1)
        loginFacebookBt.addTarget(self, action: #selector(loginFacebookAct), for: .touchUpInside)
        
        let facebookLb = UILabel()
        loginFacebookBt.addSubview(facebookLb)
        facebookLb.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        facebookLb.text = "Continue with Facebook"
        facebookLb.font = .boldSystemFont(ofSize: 18)
        facebookLb.textColor = .white
        
        let facebookImg = UIImageView()
        loginFacebookBt.addSubview(facebookImg)
        facebookImg.snp.makeConstraints { (make) in
            make.leading.top.bottom.equalToSuperview()
            make.trailing.equalTo(facebookLb.snp.leading)
        }
        
        facebookImg.image = UIImage(named: "facebook")
        facebookImg.contentMode = .scaleAspectFit
        
        
        
        
        registerLb.text = "Don't have an account? "
        registerLb.font = .boldSystemFont(ofSize: 14)
        
        
        
        self.view.addSubview(registerLb)
        registerLb.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-(self.view.frame.width / 16))
            make.top.equalTo(loginFacebookBt.snp.bottom).offset(self.view.frame.height / 40)
        }
        
        self.view.addSubview(registerBt)
        registerBt.snp.makeConstraints { (make) in
            make.leading.equalTo(registerLb.snp.trailing)
            make.width.equalToSuperview().dividedBy(8)
            make.centerY.equalTo(registerLb)
        }
        
        registerBt.setAttributedTitle(NSAttributedString(string: "Sign up", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.systemGreen]), for: .normal)
        
        registerBt.addTarget(self, action: #selector(registerAct), for: .touchUpInside)
        
    }
    
    
    // MARK: - Action func
    
    @objc func registerAct(){
        
        let vc = RegisterViewController()
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @objc func loginFacebookAct(){
        
        UIView.animate(withDuration: 0.15,
            animations: {
                self.loginFacebookBt.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.15) {
                    self.loginFacebookBt.transform = CGAffineTransform.identity
                }
            })
        
        loginManager.logIn(permissions: [], from: self) { [weak self] (result, error) in
                    
            if( AccessToken.current != nil ){
                let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                    if let error = error {
                        print("Facebook authentication with Firebase error: ", error)
                        return
                    }
                print("Login success!")
                    self!.dismiss(animated: true, completion: nil)
                    
                }
            }
        }
        
    }
    
    
    @objc func loginGoogleAct(){
        
        
        UIView.animate(withDuration: 0.15,
            animations: {
                self.loginGoogleBt.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.15) {
                    self.loginGoogleBt.transform = CGAffineTransform.identity
                }
            })
        
        GIDSignIn.sharedInstance()?.signIn()
        
        
    }
    
    
    @objc func loginAct(){
        
        UIView.animate(withDuration: 0.15,
            animations: {
                self.loginBt.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.15) {
                    self.loginBt.transform = CGAffineTransform.identity
                }
            })
        
        
        if(emailTF.text! == "" && passTF.text == ""){
            if(emailTF.text! == ""){
                line1.backgroundColor = .systemRed
                line1.alpha = 1
            }
            if(passTF.text! == ""){
                line2.backgroundColor = .systemRed
                line2.alpha = 1
            }
        }else{
            self.showSpinner(onView: self.view)
            Auth.auth().signIn(withEmail: emailTF.text!, password: passTF.text!) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                
                if(authResult != nil){
                    //login thành công
                    let mainpageVC = MainPageViewController()
                    mainpageVC.modalPresentationStyle = .fullScreen
                    self?.removeSpinner()
                    UserDefaults.standard.setValue(true, forKey: "login")
                    self!.present(mainpageVC, animated: true, completion: nil)
                    
                }else{
                    //login fail
                    let alert = UIAlertController(title: "Đăng Nhập Thất Bại", message: "Đăng nhập lại", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Thử lại", style: .cancel, handler: { (UIAlertAction) in
                        alert.dismiss(animated: true, completion: nil)
                        self?.removeSpinner()
                    }))
                    self!.present(alert, animated: true, completion: nil)
                }
                
            }
        }
        
    }

}

