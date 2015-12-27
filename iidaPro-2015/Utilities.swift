//
//  Utilities.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/24/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    
    func setNavigation(view: UIViewController) {
        view.navigationController?.setNavigationBarHidden(false, animated: false)
        view.navigationController?.navigationBar.barTintColor = UIColor(red: 86/255.0, green: 96/255.0, blue: 133/255.0, alpha: 1.0)
        view.navigationController?.navigationBar.alpha = 0.95
        view.navigationController?.navigationBar.translucent = true
        view.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        view.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

}
