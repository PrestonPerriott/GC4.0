//
//  ArticleVCExtension.swift
//  GreenCommerce4.0
//
//  Created by Preston Perriott on 11/7/17.
//  Copyright © 2017 Preston Perriott. All rights reserved.
//

import Foundation
import UIKit

extension ArticleVC: UIScrollViewDelegate{
    
    override func viewWillAppear(_ animated: Bool) {
        self.scrollView?.delegate = self
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //stop scroll view from horizontal movement 
        scrollView.contentOffset.x = 0.0
        
        //content offset of the scrollView, ie how much we scroll down
        let offset = scrollView.contentOffset.y
        var profileTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        //Whenm we pull down our offset inscreases
        if offset < 0 {
            
            let scaleForHead:CGFloat = -(offset) / (headerView?.bounds.height)!
            let sizeVaryForHead = (((headerView?.bounds.height)! * (1.0 + scaleForHead)) - (headerView?.bounds.height)!)/2.0
            
            headerTransform = CATransform3DTranslate(headerTransform, 0, sizeVaryForHead, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + scaleForHead, 1.0 + scaleForHead, 0)
            
            headerView?.layer.transform = headerTransform }
        else {
            //When we scroll up or down
            
            //for the header
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-40.0, -offset), 0)
            
            //for the label
            let lblTransform = CATransform3DMakeTranslation(0, max(-35.0, 95.0 - offset), 0)
            headerLabel?.layer.transform = lblTransform
            
            //Need blur
            
            //***********
            
            //for the profile pic
            let profileScaleFactor = (min(40, offset)) / (userImage?.bounds.height)! / 1.4
            //Slow down the animation
            let profileSizeVary = (((userImage?.bounds.height)! * (1.0 + profileScaleFactor)) - (userImage?.bounds.height)!) / 2.0
            profileTransform = CATransform3DTranslate(profileTransform, 0, profileSizeVary, 0)
            profileTransform = CATransform3DScale(profileTransform, 1.0 - profileScaleFactor, 1.0 - profileScaleFactor, 0)
            
            if offset <= 40.0 {
                if Double((userImage?.layer.zPosition)!) < Double((headerView?.layer.zPosition)!) {
                    headerView?.layer.zPosition = 0
                }
            } else {
                if Double((userImage?.layer.zPosition)!) >= Double((headerView?.layer.zPosition)!) {
                    headerView?.layer.zPosition = 2
                }
            }
        }
        //apply changes
        
        headerView?.layer.transform = headerTransform
        userImage?.layer.transform = profileTransform
        
    }
//    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
//
//    }
    override func show(_ vc: UIViewController, sender: Any?) {
        
    }
    
}
