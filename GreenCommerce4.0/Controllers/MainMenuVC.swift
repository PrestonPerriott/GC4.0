//
//  MainMenuVC.swift
//  GreenCommerce4.0
//
//  Created by Preston Perriott on 10/24/17.
//  Copyright © 2017 Preston Perriott. All rights reserved.
//

import UIKit

class MainMenuVC: BaseViewController {

    var imageAry: [UIImage] {
        //Calculated prop to get images from cities folder in assets
        var ary: [UIImage] = []
        for i in 1..<6{
            ary.append(UIImage(named: "generic\(i)")!)
        }
        return ary
    }
    
    @IBOutlet weak var bgView: UIImageView?
    @IBOutlet weak var blurEffectView: UIVisualEffectView?
    @IBOutlet weak var tfView: UIView?
    @IBOutlet weak var optionSegment: UISegmentedControl?
    @IBOutlet weak var submitButton: UIButton?
    
    @IBOutlet weak var nameTF: UITextField?
    @IBOutlet weak var emailTF: UITextField?
    @IBOutlet weak var passTF: UITextField?
    var contraint: NSLayoutConstraint? = NSLayoutConstraint()
    var emailconstraint: NSLayoutConstraint? = NSLayoutConstraint()
    var nameConstraint: NSLayoutConstraint? = NSLayoutConstraint()
    var request: APIHandler? = APIHandler()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nodePost()
        
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: .plain, target: self, action: #selector(SSASideMenu.presentLeftMenuViewController))
        
        //randomly select image from set in folder to be bg & settings
        let bgImage = Int(arc4random_uniform(UInt32(imageAry.count)))
        bgView?.contentMode = UIViewContentMode.scaleAspectFill
        bgView?.autoresizingMask = UIViewAutoresizing.flexibleWidth
    
        //Set image
        bgView?.image = imageAry[bgImage]
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        blurEffectView?.effect = blurEffect
        blurEffectView?.alpha = 0.65
        blurEffectView?.contentMode = UIViewContentMode.scaleAspectFill
        blurEffectView?.autoresizingMask = UIViewAutoresizing.flexibleWidth
        
        optionSegment?.selectedSegmentIndex = 0
        optionSegment?.tintColor = UIColor.white
        optionSegment?.setTitle("Register", forSegmentAt: 0)
        optionSegment?.setTitle("Login", forSegmentAt: 1)
        optionSegment?.addTarget(self, action: #selector(handleSegment), for: .valueChanged)
        
        emailTF?.translatesAutoresizingMaskIntoConstraints = false
        tfView?.translatesAutoresizingMaskIntoConstraints = false
        nameTF?.translatesAutoresizingMaskIntoConstraints = false
        
        passTF?.isSecureTextEntry = true
        nameTF?.layer.cornerRadius = 5
        tfView?.layer.cornerRadius = 5
        submitButton?.layer.cornerRadius = 5
        
        submitButton?.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        
        contraint = tfView?.heightAnchor.constraint(equalToConstant: 198)
        emailconstraint = emailTF?.heightAnchor.constraint(equalToConstant: 66)
        nameConstraint = nameTF?.heightAnchor.constraint(equalToConstant: 66)
        nameConstraint?.isActive = true
        emailconstraint?.isActive = true
        
        if contraint != nil {
            contraint?.isActive = true
        }else { contraint?.isActive = false }
        
        if emailconstraint != nil {
            emailconstraint?.isActive = true
        }else { emailconstraint?.isActive = false }
        
        if nameConstraint != nil {
            nameConstraint?.isActive = true
        }else {nameConstraint?.isActive = false }
        
       }
    @objc func handleSegment(){
        //change title of button for each press of the segmented controller
        submitButton?.setTitle(optionSegment?.titleForSegment(at: (optionSegment?.selectedSegmentIndex)!), for: .normal)
        
        //change the size of the text field container
        contraint?.constant = optionSegment?.selectedSegmentIndex == 1 ? 166 : 198
        emailconstraint?.constant = optionSegment?.selectedSegmentIndex == 1 ? 0 : 66
        nameConstraint?.constant = optionSegment?.selectedSegmentIndex == 1 ? 66 : 66
    }
    @objc func handleSubmit(){
        print("Pressed")
    }
    @objc func nodePost (){
        request?.getFromNodeservice(requestString: "")
    }
}
