//
//  SettingTownViewController.swift
//  iidaPro-2015
//
//  Created by akaimo on 1/4/16.
//  Copyright © 2016 akaimo. All rights reserved.
//

import UIKit

class SettingTownViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var townTableView: UITableView!
    
    var townModel: SettingTownModel!
    var townName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.townModel = SettingTownModel(town: self.townName!)
        self.setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func setupView() {
        self.title = self.townName
        
        self.view.layer.contents = UIImage(named: "Base")?.CGImage
        self.townTableView.backgroundColor = UIColor.clearColor()
        self.townTableView.sectionIndexColor = UIColor.whiteColor()
        self.townTableView.sectionIndexBackgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1)
        self.townTableView.tableFooterView = UIView()
        self.townTableView.delegate = self
        self.townTableView.dataSource = self.townModel
    }

    
    // MARK: - UItableViewDelegate
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 20))
        headerView.backgroundColor = UIColor(red: 41/255.0, green: 52/255.0, blue: 92/255.0, alpha: 0.95)
        
        let label = UILabel(frame: CGRectMake(20, 0, headerView.frame.size.width - 20, headerView.frame.size.height))
        label.text = self.townModel.sectionList[section]
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
