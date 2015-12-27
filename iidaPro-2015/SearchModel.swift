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
    var result: Bool
    var searchResultArray: RLMResults!
    
    override init() {
        self.result = false
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
    
    func fetchTrashData(str: String) {
        let pred = NSPredicate(format: "title CONTAINS[c] %@ OR read CONTAINS %@", str, str)
        self.searchResultArray = TrashCategory.objectsWithPredicate(pred).sortedResultsUsingProperty("read", ascending: true)
        self.result = true
    }
    
    private func selectTrashImage(category: String) -> UIImage {
        var img: UIImage?
        
        switch category {
        case "普通ごみ": img = UIImage(named: "S_Normal")
        case "ミックスペーパー": img = UIImage(named: "S_Mixed")
        case "プラスチック製容器包装": img = UIImage(named: "S_plastic")
        case "小物金属": img = UIImage(named: "S_Metal")
        case "使用済み乾電池": img = UIImage(named: "S_battery")
        case "空き缶・ペットボトル": img = UIImage(named: "C_Can")
        case "空きびん": img = UIImage(named: "C_Can")
        case "粗大ごみ": img = UIImage(named: "S_BigRefuse")
        case "複数": img = UIImage(named: "S_What")
        case "収集しない": img = UIImage(named: "S_No")
        default: break
        }
        
        guard let image = img else { return UIImage() }
        return image
    }
    
    
    // MARK: - UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.result ? 1 : self.sectionArray.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.result ? "" : self.sectionList[section]
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return self.result ? nil : self.sectionList
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return self.sectionList.indexOf(title)!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.result == true && self.searchResultArray.count == 0 {
            return 1
        } else if self.result == true {
            return Int(self.searchResultArray.count)
        } else {
            return Int(self.sectionArray[section].count)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: SearchCell = tableView.dequeueReusableCellWithIdentifier("Trash", forIndexPath: indexPath) as! SearchCell
        cell.backgroundColor = UIColor.clearColor()
        
        if self.result == true && self.searchResultArray.count == 0 {
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
            cell.backgroundColor = UIColor.clearColor()
            cell.selectionStyle = .None
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.textLabel?.text = "該当する品目はありません"
            return cell
            
        } else if result == true {
            cell.trashLabel.text = self.searchResultArray[UInt(indexPath.row)]["title"] as? String
            if let Category = self.searchResultArray[UInt(indexPath.row)]["category"] as? String {
                cell.trashImageView.image = self.selectTrashImage(Category)
            }
            
        } else {
            cell.trashLabel.text = self.sectionArray[indexPath.section][UInt(indexPath.row)]["title"] as? String
            if let category = self.sectionArray[indexPath.section][UInt(indexPath.row)]["category"] as? String {
                cell.trashImageView.image = self.selectTrashImage(category)
            }
        }
        
        return cell
    }
    
}
