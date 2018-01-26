//
//  LeftMenuVC.swift
//  GreenCommerce4.0
//
//  Created by Preston Perriott on 11/1/17.
//  Copyright © 2017 Preston Perriott. All rights reserved.
//

import UIKit

class LeftMenuVC: UIViewController {
    
    lazy var bgImageView: UIImageView = {
       let bg = UIImageView()
        bg.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        bg.image = #imageLiteral(resourceName: "beautifulBlur")
        bg.contentMode = UIViewContentMode.scaleAspectFill
        bg.autoresizingMask = [UIViewAutoresizing.flexibleWidth, .flexibleHeight]
        return bg
    }()

    //lazy vars delay the creation of an object until it is actually needed
    lazy var tableView: UITableView  = {
        let tbView  = UITableView()
        tbView.delegate = self
        tbView.dataSource = self
        tbView.frame = CGRect(x: 20, y: (self.view.frame.size.height - 54 * 5) / 2.0, width: self.view.frame.size.width, height: 54 * 5)
        tbView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleWidth]
        tbView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tbView.isOpaque = false
        tbView.backgroundColor = UIColor.clear
        tbView.separatorStyle = .none
        return tbView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bgImageView)
        view.addSubview(tableView)
        
    }

}
