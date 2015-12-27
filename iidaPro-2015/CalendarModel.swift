//
//  CalendarModel.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/27/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

class CalendarModel: NSObject, UITableViewDataSource {

    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 45
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Calendar", forIndexPath: indexPath) as! CalendarCell
        cell.backgroundColor = UIColor.clearColor()
        
        cell.weekdayLabel.text = "hoge"
        
        return cell
    }
}
