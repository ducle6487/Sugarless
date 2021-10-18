//
//  SetDataViewController.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 17/01/2021.
//

import UIKit

class SetDataUserViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Variable
    
    var typeData : String?
    
    var navTitle : String?
   
    var placeHolder : String?
    
    var dataTf = UITextField()
    
    var prevVC : UpdateInfoUserViewController?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .init(white: 0.95, alpha: 1)
        
        self.navigationItem.title = navTitle
        
        self.hideKeyboardWhenTappedAround()
    
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAct))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAct))
     
        self.view.addSubview(dataTf)
        dataTf.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().dividedBy(20)
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(self.view.frame.height / 20)
        }
        
//        dataTf.layer.borderWidth = 0.5
        dataTf.placeholder = placeHolder
        dataTf.backgroundColor = .white
        dataTf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 1))
        dataTf.leftViewMode = .always
        
        dataTf.delegate = self
    }
    
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return range.location < 100
    }
    
    // MARK: - action Function
    
    
    @objc func cancelAct(){
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveAct(){
        
        if typeData == "name"{
            
            if dataTf.text != ""{
                
                prevVC?.name = dataTf.text ?? ""
                prevVC?.nameValueLb.text = dataTf.text
                prevVC?.nameValueLb.textColor = .black
                
            }else{
                
                prevVC?.nameValueLb.text = "Thiết lập ngay"
                prevVC?.nameValueLb.textColor = .systemRed
                
            }
            
            prevVC?.name = dataTf.text ?? ""
            
        }else if typeData == "phone"{
            
            if dataTf.text != ""{
                
                if ValidationPhoneNumber(dataTf.text){
                    
                    prevVC?.phone = dataTf.text ?? ""
                    prevVC?.phoneValue.text = dataTf.text
                    prevVC?.phoneValue.textColor = .black
                    
                }else{
                    
                    let alert = UIAlertController(title: "Cảnh báo!!", message: "Số điện thoại không hợp lệ.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Thử lại", style: .cancel, handler: { (_ UIAlertAction) in
                        alert.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                    return
                    
                }
                
                
                
            }else{
                
                prevVC?.phoneValue.text = "Thiết lập ngay"
                prevVC?.phoneValue.textColor = .systemRed
                
            }
            
            prevVC?.phone = dataTf.text ?? ""
            
        }else if typeData == "des"{
            
            
            if dataTf.text != ""{
                
                prevVC?.des = dataTf.text ?? ""
                prevVC?.desValueLb.text = dataTf.text
                prevVC?.desValueLb.textColor = .black
                
            }else{
                
                prevVC?.desValueLb.text = "Thiết lập ngay"
                prevVC?.desValueLb.textColor = .systemRed
                
            }
            
            prevVC?.des = dataTf.text ?? ""
            
        }
        
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    // MARK: - utility Function
    
    func ValidationPhoneNumber(_ phone:String?) -> Bool {
        var result = false
        if phone != nil{
            // chú ý --> (0)+(3|5|7|8|9)+([0-9]{8}) khác LoginViewController
            let PHONE_REGEX = "^(0)+(3|5|7|8|9)+([0-9]{8})$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
            result =  phoneTest.evaluate(with: phone)
        }
        return result
    }
    

}
