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
        
        GioHangUtils.getCartSavedInUserDefault()
        
        let vc = UITabBarController()
        let item1 = UITabBarItem()
        item1.title = "Shop"
        item1.image = UIImage(named: "shop")
        let mainVC = MainPageViewController()
        mainVC.rootVC = vc
        let mainPageVC = UINavigationController(rootViewController: mainVC)
        mainPageVC.tabBarItem = item1
        
        let item2 = UITabBarItem()
        item2.title = "Explore"
        item2.image = UIImage(named: "search")
        let typeProductVC = TypeProductViewController()
        typeProductVC.tabBarItem = item2
        
        let item3 = UITabBarItem()
        item3.title = "Cart"
        item3.image = UIImage(named: "cart")
        let cart = GioHangViewController()
        cart.tabBarItem = item3
        
        
        let item4 = UITabBarItem()
        item4.image = UIImage(named: "account")
        item4.title = "Account"
        let account = AccountViewController()
        account.tabBarItem = item4
        
        
        vc.viewControllers = [mainPageVC,typeProductVC,cart,account]
        
        let test = UINavigationController(rootViewController: DeliveryDescriptionViewController())
        
        
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
            
            if Error != nil{
                
                print(Error?.localizedDescription)
                
                return
                
            }
            
            print("login google")
            let url: String = Auth.auth().currentUser?.photoURL?.absoluteString  ?? ""
            let profile = ProfileUser(id: Auth.auth().currentUser?.uid ?? "", name: Auth.auth().currentUser?.displayName ?? Auth.auth().currentUser?.email ?? "", img: url, des: "anh duc dep trai vai ", email: Auth.auth().currentUser?.email ?? "", ns: "", gioitinh: "", phone: "")
            ProfileUtils.installProfile(profile: profile)
            
            window = UIWindow(frame: UIScreen.main.bounds)
            
            let vc = UITabBarController()
            let item1 = UITabBarItem()
            item1.title = "Shop"
            item1.image = UIImage(named: "shop")
            let mainVC = MainPageViewController()
            mainVC.rootVC = vc
            let mainPageVC = UINavigationController(rootViewController: mainVC)
            mainPageVC.tabBarItem = item1
            
            let item2 = UITabBarItem()
            item2.title = "Explore"
            item2.image = UIImage(named: "search")
            let typeProductVC = TypeProductViewController()
            typeProductVC.tabBarItem = item2
            
            let item3 = UITabBarItem()
            item3.title = "Cart"
            item3.image = UIImage(named: "cart")
            let cart = GioHangViewController()
            cart.tabBarItem = item3
            
            
            let item4 = UITabBarItem()
            item4.image = UIImage(named: "account")
            item4.title = "Account"
            let account = AccountViewController()
            account.tabBarItem = item4
            
            
            vc.viewControllers = [mainPageVC,typeProductVC,cart,account]
            
            
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
            
        }


      // ...
    }
    
    

}

