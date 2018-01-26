//
//  ArticleView.swift
//  GreenCommerce4.0
//
//  Created by Preston Perriott on 10/24/17.
//  Copyright © 2017 Preston Perriott. All rights reserved.
//

import UIKit

class ArticleView: UIView {
    
    var hasArticles: Bool = false
    var view: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func loadFromNib() -> ArticleView {
        let object: ArticleView = Bundle.main.loadNibNamed("ArticleView", owner: self, options: nil)![0] as! ArticleView
        
        object.backgroundColor = UIColor.green.withAlphaComponent(0.45)
        object.layer.borderWidth = 1.5
        object.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.25).cgColor
        object.titleLabel.text = "Title 1"
        object.titleLabel.textColor = UIColor.red

        return object
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    init?(frame: CGRect, articles: Array<ArticleObj>) {
        super.init(frame: frame)
        commonInit()
    }
    

   
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       commonInit()
    }
    
    func commonInit() {

        view = loadFromNib()
        view.frame = bounds
        addSubview(view)
        
    }
    
    func ViewShowsArticles(item: Bool)->(Bool) {
        
        return item
    }
    
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //        setUpView()
    //
    //    }
    
}
