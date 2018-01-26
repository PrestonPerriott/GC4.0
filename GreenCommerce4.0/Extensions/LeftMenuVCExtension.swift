//
//  LeftMenuVCExtension.swift
//  GreenCommerce4.0
//
//  Created by Preston Perriott on 11/1/17.
//  Copyright © 2017 Preston Perriott. All rights reserved.
//

import Foundation
import UIKit

extension LeftMenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let titles = ["Articles", "Parks & Shops", "Stuffs" ,"Profile" ,"Logout"]
        
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name: "HelveticaNeue", size: 21)
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.text = titles[indexPath.row]
        cell.selectionStyle = . none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let articlesVC = ArticleVC(nibName: "ArticleVC", bundle: nil)
            present(articlesVC, animated: true, completion: nil)
        case 1:
            break;
        default:
            break;
        }
    }
}
