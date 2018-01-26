//
//  ArticleCellView.swift
//  GreenCommerce4.0
//
//  Created by Preston Perriott on 11/14/17.
//  Copyright © 2017 Preston Perriott. All rights reserved.
//

import UIKit

class ArticleCellView: UIView {
    @IBOutlet weak var leftImage: UIImageView!
    
    @IBOutlet weak var rightImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentSnippetLabel: UILabel!
    let imageOnRight: Bool = true
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.gray.cgColor
    }
    
}
