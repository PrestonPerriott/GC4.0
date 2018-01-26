//
//  Reachability.swift
//  GreenCommerce4.0
//
//  Created by Preston Perriott on 10/20/17.
//  Copyright © 2017 Preston Perriott. All rights reserved.
//

import SystemConfiguration
import UIKit


protocol notifierStatusDidChange: class {
    func didChange(status: Bool) -> (Bool)
}

//For the notification
let ReachabilityDidChangeNotificationName = "ReachabilityDidChangeNotification"

//need to inform app of network state changes
//send notification w/ network status
//we do so using an enum of the diff states
enum NetworkStatus {
    case notReachable
    case reachableViaWifi
    case reachableViwWWAN
}

class Reachability: NSObject {
    //property to store SCNReachability  object
    private var networkReachability : SCNetworkReachability?
    
    weak var delegate: notifierStatusDidChange?
    
    //create an initializer to monitor reachability of target host
    //takes hostname & creates SCNReachability Obj
    //Mkae sure object is created
    init?(hostName: String) {
        networkReachability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, (hostName as NSString).utf8String!)
        super.init()
        if networkReachability == nil {
            return nil
        }
    }
    
    //what if we what to create a ref to the network address?
    //another initialzer takes a pointer to a network address
    //we therefore call it inside an unsafepointer func
    //Make sure obj exists
    init?(hostAddress: sockaddr_in){
        var address = hostAddress
        
        guard let defaultRouteReachability = withUnsafePointer(to: &address, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1){ SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, $0) }
            })
            else
            {
                return nil
            }
             networkReachability = defaultRouteReachability
            super.init()
        if networkReachability == nil {
            return nil
        }
    }
    
    //class method to create a reachability instance to control if we are indeed connected to the net
    //uses the above func with net worj address
    static func reachForInternetConnect() -> Reachability? {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        return Reachability(hostAddress: zeroAddress)
    }
    
    //class method to creates a reachability instance to check if we are connected to a local WIFI
    //If local we point to  169.254.0.0
    static func reachForLocalWiFi() -> Reachability? {
        var localWiFiAddr = sockaddr_in()
        localWiFiAddr.sin_len = UInt8(MemoryLayout.size(ofValue: localWiFiAddr))
        localWiFiAddr.sin_family = sa_family_t(AF_INET)
        // IN_LINKLOCALNETNUM is defined in <netinet/in.h> as 169.254.0.0 (0xA9FE0000).
        localWiFiAddr.sin_addr.s_addr = 0xA9FE0000
        return Reachability(hostAddress: localWiFiAddr)
    }
    
    //Now come the funcs to start and stop notifying
    //And the property to save state if we are notifying chnages
    private var notifying: Bool = false
    
    func startNotifier() -> Bool {
        
        //Check to see if were already notifying
        guard notifying == false else {
            if !notifying{
                delegate?.didChange(status: notifying)
            }else {
                delegate?.didChange(status: notifying)
            }
                
            
            
            return false
        }
        
        //If not we create a SCNetworkReachContext,
        //its info param is assigned self
        
        var context = SCNetworkReachabilityContext()
        context.info = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
        
        //Set callback function passing it context
        //*info param with ref to self gets passed to data block*
        //If successful we schedule the netWReach reference in a run loop
        guard let reachability = networkReachability, SCNetworkReachabilitySetCallback(reachability, {
            (target:SCNetworkReachability, flags: SCNetworkReachabilityFlags, info:UnsafeMutableRawPointer?) in
            if let currentInfo = info {
                let infoObject = Unmanaged<AnyObject>.fromOpaque(currentInfo).takeUnretainedValue()
                if infoObject is Reachability {
                    let networkReachability = infoObject as! Reachability
                    
                    NotificationCenter.default.post(name: Notification.Name(rawValue: ReachabilityDidChangeNotificationName), object: networkReachability)
                }
            }
        }, &context) == true else { return false }
        
        guard SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue) == true else { return false }
        
        notifying = true
        delegate?.didChange(status: notifying)
        return notifying
    }
    
    //To stop the snotifier we unschedule
    //networkReachability ref from the run loop
    func stopNotifier() {
        if let reachability = networkReachability, notifying == true {
            SCNetworkReachabilityScheduleWithRunLoop(reachability, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode as! CFString)
            notifying = false
        }
    }
    
    //We also stop when the object is deallocated
    deinit {
        stopNotifier()
    }
    
    //Computer property to find out the state of network Reachability and get current flags
    private var flags: SCNetworkReachabilityFlags {
        
        var flags = SCNetworkReachabilityFlags(rawValue: 0)
        if let reachability = networkReachability, withUnsafeMutablePointer(to: &flags, {SCNetworkReachabilityGetFlags(reachability,UnsafeMutablePointer($0))}) == true {
            return flags
        }else {
            return []
        }
    }
    
    //Here is a method to return the reachability status of flags passed to it
    var currentReachStatus: NetworkStatus {
        if flags.contains(.reachable) == false {
            return .notReachable
        }
        else if flags.contains(.isWWAN) == true {
            return .reachableViwWWAN
        }
        else if flags.contains(.connectionRequired) == false {
            return .reachableViaWifi
            //reachable but no connection required
        }
        else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
            return .reachableViaWifi
            //connection is on-demand if calling app is
            //using the CFSocketStream or higher API and
            // no user intervention is needed
        }
        else {
            return .notReachable
        }
    }
    
    //Now a method to see the reachability status of the current flags of the network reach ref
    //Comp prop verifys our connection
    var isReachable: Bool {
        switch currentReachStatus {
        case .notReachable:
            return false
        case .reachableViaWifi, .reachableViwWWAN:
            return true
        }
    }
}



