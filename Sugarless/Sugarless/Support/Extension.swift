//
//  Extension.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 22/12/2020.
//

import UIKit

extension UIColor {
    // Method returns a custom color
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, a: CGFloat) -> UIColor {
        return .init(red: blue / 255, green: green / 255, blue: blue / 255, alpha: a)
    }
    
}
var vSpinner : UIView?
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showSpinner(onView : UIView) {
            let spinnerView = UIView.init(frame: onView.bounds)
            spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
            let ai = UIActivityIndicatorView.init(style: .whiteLarge)
            ai.startAnimating()
            ai.center = spinnerView.center
            
            DispatchQueue.main.async {
                spinnerView.addSubview(ai)
                onView.addSubview(spinnerView)
            }
            
            vSpinner = spinnerView
        }
        
        func removeSpinner() {
            DispatchQueue.main.async {
                vSpinner?.removeFromSuperview()
                vSpinner = nil
            }
        }
}
