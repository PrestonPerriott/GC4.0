//
//  AppDelegate.swift
//  GreenCommerce4.0
//
//  Created by Preston Perriott on 10/20/17.
//  Copyright © 2017 Preston Perriott. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SSASideMenuDelegate {

    var window: UIWindow?
    var mainScreen: MainMenuVC = MainMenuVC()
    var leftMenu: LeftMenuVC = LeftMenuVC()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.isStatusBarHidden = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let main = storyboard.instantiateInitialViewController()
        
        let sideMenu = SSASideMenu(contentViewController: UINavigationController(rootViewController: main!), leftMenuViewController: leftMenu)
        sideMenu.configure(SSASideMenu.MenuViewEffect(fade: true, scale: true, scaleBackground: true, parallaxEnabled: true, bouncesHorizontally: true, statusBarStyle: .black))
        sideMenu.configure(SSASideMenu.ContentViewEffect(alpha: 0.65, scale: 0.7, landscapeOffsetX: 30, portraitOffsetX: 30, minParallaxContentRelativeValue: -25.0, maxParallaxContentRelativeValue: 25.0, interactivePopGestureRecognizerEnabled: true))
        sideMenu.configure(SSASideMenu.ContentViewShadow(enabled: true, color: UIColor.black, opacity: 0.6, radius: 6.0))
        sideMenu.configure(SSASideMenu.SideMenuOptions(animationDuration: 0.5, panGestureEnabled: true, panDirection: .everyWhere, type: .slip, panMinimumOpenThreshold: 60, menuViewControllerTransformation: CGAffineTransform.init(scaleX: 1.5, y: 1.5), backgroundTransformation: CGAffineTransform.init(scaleX: 1.7, y: 1.7), endAllEditing: false))
        
    
        sideMenu.delegate = self
        
        window?.rootViewController = sideMenu
        window?.makeKeyAndVisible()
    
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

