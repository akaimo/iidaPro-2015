//
//  SearchModel.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/23/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit
import RealmSwift

class SearchModel: NSObject, UITableViewDataSource {
    var sectionArray: [RLMResults] = []
    let sectionList = ["あ", "か", "さ", "た", "な", "は", "ま", "や", "ら", "わ"]
    
    override init() {
        super.init()
        self.fetchData()
    }
    
    private func fetchData() {
        for num in 0...9 {
           self.sectionArray.append(self.fetchInitial(num))
        }
    }
    
    private func fetchInitial(num: Int) -> RLMResults {
        var pred = NSPredicate()
        
        switch num {
        case 0:
            pred = NSPredicate(format:"read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@", "あ", "い", "う", "え", "お")
            
        case 1:
            pred = NSPredicate(format:"read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@", "か", "き", "く", "け", "こ")
            
        case 2:
            pred = NSPredicate(format:"read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@", "さ", "し", "す", "せ", "そ")
            
        case 3:
            pred = NSPredicate(format:"read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@", "た", "ち", "つ", "て", "と")
            
        case 4:
            pred = NSPredicate(format:"read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@", "な", "に", "ぬ", "ね", "の")
            
        case 5:
            pred = NSPredicate(format:"read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@", "は", "ひ", "ふ", "へ", "ほ")
            
        case 6:
            pred = NSPredicate(format:"read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@", "ま", "み", "む", "め", "も")
            
        case 7:
            pred = NSPredicate(format: "read_head = %@ OR read_head = %@ or read_head = %@", "や", "ゆ", "よ")
            
        case 8:
            pred = NSPredicate(format:"read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@ OR read_head = %@", "ら", "り", "る", "れ", "ろ")
            
        case 9:
            pred = NSPredicate(format:"read_head = %@ OR read_head = %@", "わ", "を")
            
        default: break
        }
        
        return TrashCategory.objectsWithPredicate(pred).sortedResultsUsingProperty("read", ascending: true)
    }
    
    
    
    // MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.sectionArray.count
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
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = self.sectionArray[indexPath.section][UInt(indexPath.row)]["title"] as? String
        return cell
    }

}
