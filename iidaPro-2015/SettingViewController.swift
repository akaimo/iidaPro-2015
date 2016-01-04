//
//  SettingViewController.swift
//  iidaPro-2015
//
//  Created by akaimo on 1/3/16.
//  Copyright © 2016 akaimo. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet weak var settingTableView: UITableView!
    
    var settingModel: SettingModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.settingModel = SettingModel()
        self.settingTableView.dataSource = self.settingModel
        
        self.setupView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func setupView() {
        Utilities().setNavigation(self)
        self.title = "地域設定"
        
        let nib = UINib(nibName: "GPSSearchTableViewCell", bundle: nil)
        self.settingTableView.registerNib(nib, forCellReuseIdentifier: "GPSSearch")
    }

}
