//
//  AppDelegate.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 21/12/2020.
//

import UIKit
import Firebase
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions)
        
        let vc = ViewController()
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        

        
        return true
    }
    
    
    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
        
    }

    

}

