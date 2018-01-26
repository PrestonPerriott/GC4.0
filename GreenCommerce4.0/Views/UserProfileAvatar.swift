//
//  UserProfileAvatar.swift
//  GreenCommerce4.0
//
//  Created by Preston Perriott on 11/13/17.
//  Copyright © 2017 Preston Perriott. All rights reserved.
//

import UIKit

class UserProfileAvatar: UIImageView {

    override func awakeFromNib() {
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth  = 3.0
    }

}
