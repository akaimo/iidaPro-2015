//
//  SearchViewController.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/23/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var searchTableView: UITableView!
    
    var searchModel: SearchModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchModel = SearchModel()
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self.searchModel

        self.title = "分別辞典"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 86/255.0, green: 96/255.0, blue: 133/255.0, alpha: 1.0)
        self.navigationController?.navigationBar.alpha = 0.95
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
