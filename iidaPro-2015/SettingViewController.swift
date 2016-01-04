//
//  SettingViewController.swift
//  iidaPro-2015
//
//  Created by akaimo on 1/3/16.
//  Copyright © 2016 akaimo. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var settingTableView: UITableView!
    
    var settingModel: SettingModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.settingModel = SettingModel()
        self.settingTableView.dataSource = self.settingModel
        self.settingTableView.delegate = self
        
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
        self.settingTableView.backgroundColor = UIColor.clearColor()
        self.settingTableView.tableFooterView = UIView()
        self.view.layer.contents = UIImage(named: "Base")?.CGImage
    }
    
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 1 {
            return 66.0
        }
        return 44.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 20))
        headerView.backgroundColor = UIColor(red: 41/255.0, green: 52/255.0, blue: 92/255.0, alpha: 0.95)
        
        let label = UILabel(frame: CGRectMake(20, 0, headerView.frame.size.width - 20, headerView.frame.size.height))
        label.text = self.settingModel.sectionArray[section]
        label.font = UIFont.boldSystemFontOfSize(16.0)
        label.shadowOffset = CGSizeMake(0, 1)
        label.shadowColor = UIColor.grayColor()
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.whiteColor()
        
        headerView.addSubview(label)
        tableView.sectionHeaderHeight = headerView.frame.size.height
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }

}
