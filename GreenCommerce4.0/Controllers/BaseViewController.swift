//
//  ViewController.swift
//  GreenCommerce4.0
//
//  Created by Preston Perriott on 10/20/17.
//  Copyright © 2017 Preston Perriott. All rights reserved.
//

import UIKit


class BaseViewController: UIViewController, notifierStatusDidChange{

    //reachability class property in VC
    var reachability: Reachability? = Reachability.reachForInternetConnect()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkReach()
        reachability?.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        //On view load we want to add the VC as an observer to the notification
        
        print("\(String(describing: reachability?.currentReachStatus))")
        
        //Probably need a delegate method for this
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityDidChange(_:)), name: NSNotification.Name(rawValue: ReachabilityDidChangeNotificationName), object: nil)
        _ = reachability?.startNotifier()
    }

    //when a notification is received, the following func is called
    @objc func reachabilityDidChange(_ notification: Notification){
        checkReach()
    }
    
    func checkReach() {
        guard let r = reachability else {
            return
        }
        if r.isReachable{
            self.view.layer.borderColor = UIColor.blue.withAlphaComponent(0.5).cgColor
            self.view.layer.borderWidth = 1.5
            self.view.layoutSubviews()
            self.view.reloadInputViews()
        }else {
            self.view.layer.borderColor = UIColor.red.withAlphaComponent(0.5).cgColor
            self.view.layer.borderWidth = 1.5
            self.view.layoutSubviews()
            self.view.reloadInputViews()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        reachability?.stopNotifier()
    }
    
    func didChange(status: Bool) -> (Bool) {
        checkReach()
        return status
    }
}

