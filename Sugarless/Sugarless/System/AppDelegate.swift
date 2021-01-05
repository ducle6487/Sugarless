//
//  AppDelegate.swift
//  Sugarless
//
//  Created by Duc'sMacBook on 21/12/2020.
//

import UIKit
import FirebaseAuth
import Firebase
import FBSDKCoreKit
import GoogleSignIn
import FBSDKLoginKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions)
        
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
            
            let vc = MainPageViewController()
            
            window?.rootViewController = vc
            window?.makeKeyAndVisible()


        
        
        
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self

        
        return true
    }
    
    
    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
        
        return GIDSignIn.sharedInstance().handle(url)
        
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        // ...
        return
      }

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)

        Auth.auth().signIn(with: credential) { [self] (AuthDataResult, Error) in
            
            let vc = MainPageViewController()
            self.window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }


      // ...
    }

    
    

}

