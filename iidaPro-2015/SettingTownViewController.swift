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
    var townName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.townModel = SettingTownModel(town: self.townName)
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
    
    private func alartDistrict(district: District) {
        guard let town = district["town"] as? String else { return }
        let message = String(format: "%@%@%@", "地域を「", town, "」に設定しますか？")
        
        let alertController = UIAlertController(title: "登録地域", message: message, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .Default, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: { _ in self.registerDistrict(district) })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    private func registerDistrict(district: District) {
        let ary = ["num", "area", "town", "read", "read_head", "office","normal_1", "normal_2",
            "bottle", "plastic", "mixedPaper", "bigRefuse_date", "bigRefuse_1", "bigRefuse_2"]
        var dic: [String:AnyObject] = [:]
        
        for key in ary {
            if let num = district[key] as? Int { dic[key] = num }
            if let str = district[key] as? String { dic[key] = str }
        }
        
        let ud = NSUserDefaults.standardUserDefaults() 
        ud.setObject(dic, forKey: "district")
        ud.synchronize()
        
        self.navigationController?.popToRootViewControllerAnimated(true)
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let district = self.townModel.sectionArray[indexPath.section][UInt(indexPath.row)] as? District
        if let d = district {
            self.alartDistrict(d)
        }
    }
}
