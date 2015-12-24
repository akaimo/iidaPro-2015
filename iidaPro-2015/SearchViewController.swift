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
        
        Utilities().setNavigation(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
