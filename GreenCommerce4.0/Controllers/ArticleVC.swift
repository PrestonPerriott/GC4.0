//
//  ArticleVC.swift
//  GreenCommerce4.0
//
//  Created by Preston Perriott on 11/2/17.
//  Copyright © 2017 Preston Perriott. All rights reserved.
//

import UIKit

class ArticleVC: UIViewController {

    @IBOutlet var headerView: UIView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var articleTitle: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var articleDate: UILabel!
    
    
    
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var articleAuthor: UILabel!
    
    //calc prop for the images
    var imgsAry: [UIImage] = {
        var itms: [UIImage] = []
        
        for i in 1..<9{
            itms.append(UIImage(named: "landscape\(i)")!)
        }
        return itms
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        headerImageView = UIImageView(frame: headerView.bounds)
        //randomly select image from set in folder to be bg & settings
        let bgImage = Int(arc4random_uniform(UInt32(imgsAry.count)))
        headerImageView?.image = imgsAry[bgImage]
        headerImageView?.contentMode = UIViewContentMode.scaleAspectFill
        headerView.insertSubview(headerImageView, belowSubview: headerLabel)
        headerView.clipsToBounds = true
        
    }
}
