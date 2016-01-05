//
//  SettingModel.swift
//  iidaPro-2015
//
//  Created by akaimo on 1/3/16.
//  Copyright © 2016 akaimo. All rights reserved.
//

import UIKit

class SettingModel: NSObject, UITableViewDataSource {
    let areaData = ["川崎区", "幸区", "中原区", "高津区", "宮前区", "多摩区", "麻生区"]
    let sectionArray = ["パターンから選ぶ", "GPSを利用する"]
    
    // MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionArray.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionArray[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return 1
        }
        return self.areaData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell: GPSSearchTableViewCell = tableView.dequeueReusableCellWithIdentifier("GPSSearch", forIndexPath: indexPath) as! GPSSearchTableViewCell
            cell.backgroundColor = UIColor.clearColor()
            cell.searchBtn?.addTarget(self, action: "gpsSearch:", forControlEvents: .TouchUpInside)
            cell.searchBtn?.setBackgroundImage(UIImage(named: "tappedBtnColor"), forState: .Highlighted)
            
            return cell
        }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = self.areaData[indexPath.row]
        cell.backgroundColor = UIColor.clearColor()
        cell.textLabel?.textColor = UIColor.whiteColor()
        
        return cell
    }
    
    
    func gpsSearch(sender: UIButton) {
        // TODO: gps search
    }

}
