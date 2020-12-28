//
//  RegisterViewController.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 26/12/2020.
//

import UIKit
import SnapKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    // MARK: - Variable
    
    
    var emailLb = UILabel()
    var emailTf = UITextField()
    
    var passLb = UILabel()
    var passTf = UITextField()
    
    var rePassLb = UILabel()
    var rePassTf = UITextField()
    
    var privacyLb = UILabel()
    
    var signUpBt = UIButton()
    
    var loginLb = UILabel()
    var loginBt = UIButton()
    
    
    let line1 = UIView()
    let line3 = UIView()
    let line2 = UIView()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.hideKeyboardWhenTappedAround()
        setupUI()
    }

    // MARK: - Setup UI
    
    func setupUI(){
        
        self.view.addSubview(passLb)
        passLb.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.view.frame.width / 17)
            
            make.centerY.equalToSuperview()
        }
        
        passLb.text = "Password"
        passLb.textColor = .gray
        passLb.font = UIFont.boldSystemFont(ofSize: 15)
        
        self.view.addSubview(passTf)
        passTf.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(self.view.frame.width / 17)
            make.trailing.equalToSuperview().offset(-(self.view.frame.width / 17))
            make.top.equalTo(passLb.snp.bottom)
            make.height.equalToSuperview().dividedBy(18)
        }
        
        passTf.placeholder = "Enter your Password"
        passTf.isSecureTextEntry.toggle()
        if #available(iOS 12.0, *) {
            passTf.textContentType = .oneTimeCode
        } else {
            // Fallback on earlier versions
        }
        
        self.view.addSubview(line1)
        line1.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(passTf)
            make.top.equalTo(passTf.snp.bottom)
            make.height.equalTo(1)
        }
        
        line1.backgroundColor = .gray
        line1.alpha = 0.3
        
        self.view.addSubview(emailTf)
        emailTf.snp.makeConstraints { (make) in
            make.bottom.equalTo(passLb.snp.top).offset(-(self.view.frame.height / 35))
            make.leading.height.trailing.equalTo(passTf)
        }
        
        emailTf.placeholder = "Enter your Email"
        emailTf.textContentType = .emailAddress
        
        self.view.addSubview(line2)
        
        line2.snp.makeConstraints { (make) in
            make.trailing.leading.equalTo(passTf)
            make.top.equalTo(emailTf.snp.bottom)
            make.height.equalTo(1)
        }
        
        line2.backgroundColor = .gray
        line2.alpha = 0.3
        
        
        self.view.addSubview(emailLb)
        emailLb.snp.makeConstraints { (make) in
            make.leading.equalTo(passLb)
            make.bottom.equalTo(emailTf.snp.top)
            
        }
        
        emailLb.text = "Email"
        emailLb.textColor = UIColor.gray
        emailLb.font = UIFont.boldSystemFont(ofSize: 15)
        

        self.view.addSubview(rePassLb)
        rePassLb.snp.makeConstraints { (make) in
            make.leading.equalTo(passLb)
            make.top.equalTo(passTf.snp.bottom).offset(self.view.frame.height / 35)
        }
        
        rePassLb.text = "rePassword"
        rePassLb.textColor = .gray
        rePassLb.font = UIFont.boldSystemFont(ofSize: 15)
        
        
        self.view.addSubview(rePassTf)
        rePassTf.snp.makeConstraints { (make) in
            make.leading.height.trailing.equalTo(passTf)
            make.top.equalTo(rePassLb.snp.bottom).offset(self.view.frame.height / 35)
        }
        
        rePassTf.placeholder = "reEnter your Password"
        rePassTf.isSecureTextEntry.toggle()
        if #available(iOS 12.0, *) {
            rePassTf.textContentType = .oneTimeCode
        } else {
            // Fallback on earlier versions
        }
        
        self.view.addSubview(line3)
        line3.snp.makeConstraints { (make) in
            make.top.equalTo(rePassTf.snp.bottom)
            make.height.leading.trailing.equalTo(line1)
        }
     
        line3.backgroundColor = .gray
        line3.alpha = 0.3
        
        self.view.addSubview(privacyLb)
        privacyLb.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(passTf)
            make.top.equalTo(rePassTf.snp.bottom).offset(self.view.frame.height / 40)
        }
        
        let string = NSMutableAttributedString(string: "By continuing you agree to our Terms of Service\nand Privacy Policy.", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
        string.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemGreen, range: NSRange(location: 31, length: 16))
        string.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemGreen, range: NSRange(location: 52, length: 14))
        privacyLb.attributedText = string
        
        privacyLb.font = .boldSystemFont(ofSize: 13.5)
        privacyLb.numberOfLines = 2
        
        
        self.view.addSubview(signUpBt)
        signUpBt.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(passTf)
            make.height.equalToSuperview().dividedBy(14)
            make.top.equalTo(privacyLb.snp.bottom).offset(self.view.frame.height / 20)
        }
        
        signUpBt.backgroundColor = .systemGreen
        signUpBt.setAttributedTitle(NSAttributedString(string: "Register", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 22), NSAttributedString.Key.foregroundColor : UIColor.white]), for: .normal)
        signUpBt.layer.cornerRadius = 20
        signUpBt.addTarget(self, action: #selector(signUpAct), for: .touchUpInside)
        
        
        self.view.addSubview(loginLb)
        loginLb.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(-(self.view.frame.width / 16))
            make.top.equalTo(signUpBt.snp.bottom).offset(self.view.frame.height / 20)
        }
        
        loginLb.text = "Already have an account? "
        loginLb.font = .boldSystemFont(ofSize: 14)
        
        
        self.view.addSubview(loginBt)
        loginBt.snp.makeConstraints { (make) in
            make.leading.equalTo(loginLb.snp.trailing)
            make.centerY.equalTo(loginLb)
        }
        
        loginBt.setAttributedTitle(NSAttributedString(string: "Login", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGreen, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]), for: .normal)
        
        loginBt.addTarget(self, action: #selector(loginAct), for: .touchUpInside)
        
        
    }

    // MARK: - Action function
    
    
    @objc func signUpAct(){
        
        line1.backgroundColor = .gray
        line2.backgroundColor = .gray
        line3.backgroundColor = .gray
        line1.alpha = 0.3
        line2.alpha = 0.3
        line3.alpha = 0.3
        
        UIView.animate(withDuration: 0.15,
            animations: {
                self.signUpBt.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            },
            completion: { _ in
                UIView.animate(withDuration: 0.15) {
                    self.signUpBt.transform = CGAffineTransform.identity
                }
            })
        
        
        
        if !isValidEmail(email: emailTf.text ?? "") && passTf.text == ""{
            
            if !isValidEmail(email: emailTf.text ?? ""){
                line1.backgroundColor = .systemRed
                line1.alpha = 1
            }
            if passTf.text == ""{
                line2.backgroundColor = .systemRed
                line3.backgroundColor = .systemRed
                line3.alpha = 1
                line2.alpha = 1
            }
            
        }else{
            
            if(passTf.text != rePassTf.text){
                line2.backgroundColor = .systemRed
                line3.backgroundColor = .systemRed
                line2.alpha = 1
                line3.alpha = 1
            }else{
                self.showSpinner(onView: self.view)
                Auth.auth().createUser(withEmail: emailTf.text!, password: passTf.text!) { (result, error) in
                    
                    if error != nil{
                        
                        let alert = UIAlertController(title: "Sign Up Fail", message: error?.localizedDescription, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: { (UIAlertAction) in
                            alert.dismiss(animated: true, completion: nil)
                            self.removeSpinner()
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                    }else{
                        
                        let alert = UIAlertController(title: "Sign Up Success", message: "Login Now", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Login", style: .cancel, handler: { (UIAlertAction) in
                            alert.dismiss(animated: true, completion: nil)
                            self.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                        self.removeSpinner()
                    }
                    
                }
                
            }
            
        }
        
        
    }
    
    
    @objc func loginAct(){
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    // MARK: - Utility function
    
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
