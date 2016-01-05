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
        self.townTableView.tableFooterView = UIView()
        self.townTableView.delegate = self
        self.townTableView.dataSource = self.townModel
    }

}
