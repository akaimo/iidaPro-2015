//
//  SettingTownModel.swift
//  iidaPro-2015
//
//  Created by akaimo on 1/5/16.
//  Copyright © 2016 akaimo. All rights reserved.
//

import UIKit

class SettingTownModel: NSObject, UITableViewDataSource {
    var sectionArray: [RLMResults] = []
    let sectionList = ["あ", "か", "さ", "た", "な", "は", "ま", "や", "ら", "わ"]
    
    init(town: String) {
        super.init()
        self.fetchData(town)
    }
    
    private func fetchData(town: String) {
        for num in 0...9 {
           self.sectionArray.append(self.fetchInitial(num, town: town))
        }
    }
    
    private func fetchInitial(num: Int, town: String) -> RLMResults {
        var pred = NSPredicate()
        
        switch num {
        case 0:
            pred = NSPredicate(format:"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@)", town, "あ", "い", "う", "え", "お")
            
        case 1:
            pred = NSPredicate(format:"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@)", town, "か", "き", "く", "け", "こ")
            
        case 2:
            pred = NSPredicate(format:"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@)", town, "さ", "し", "す", "せ", "そ")
            
        case 3:
            pred = NSPredicate(format:"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@)", town, "た", "ち", "つ", "て", "と")
            
        case 4:
            pred = NSPredicate(format:"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@)", town, "な", "に", "ぬ", "ね", "の")
            
        case 5:
            pred = NSPredicate(format:"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@)", town, "は", "ひ", "ふ", "へ", "ほ")
            
        case 6:
            pred = NSPredicate(format:"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@)", town, "ま", "み", "む", "め", "も")
            
        case 7:
            pred = NSPredicate(format: "area = %@ AND (read_head = %@ OR read_head = %@ or read_head = %@)", town, "や", "ゆ", "よ")
            
        case 8:
            pred = NSPredicate(format:"area = %@ AND (read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@)", town, "ら", "り", "る", "れ", "ろ")
            
        case 9:
            pred = NSPredicate(format:"area = %@ AND (read_head = %@ OR read_head = %@)", town, "わ", "を")
            
        default: break
        }
        
        return District.objectsWithPredicate(pred).sortedResultsUsingProperty("read", ascending: true)
    }
    
    
    // MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionList.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionList[section]
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return self.sectionList
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return self.sectionList.indexOf(title)!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(self.sectionArray[section].count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let district = self.sectionArray[indexPath.section][UInt(indexPath.row)] as! District
        cell.textLabel?.text = district["town"] as? String

        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }

}
