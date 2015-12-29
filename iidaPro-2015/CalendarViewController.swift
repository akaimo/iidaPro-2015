//
//  CalendarViewController.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/27/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var calendarTableView: UITableView!
    var calendarModel: CalendarModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.calendarModel = CalendarModel()
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
        self.title = "カレンダー"
        self.view.layer.contents = UIImage(named: "Base")?.CGImage
        
        self.calendarTableView.delegate = self
        self.calendarTableView.dataSource = self.calendarModel
        self.calendarTableView.backgroundColor = UIColor.clearColor()
        
        let nib = UINib(nibName: "CalendarCell", bundle: nil)
        self.calendarTableView.registerNib(nib, forCellReuseIdentifier: "Calendar")
    }
    
    
    // MARK: - UITableViewDelefate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath == self.calendarModel.todayIndexPath {
            return 110.0
        }
        return 55.0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.bounds.size.width, 20))
        headerView.backgroundColor = UIColor(red: 41/255.0, green: 52/255.0, blue: 92/255.0, alpha: 0.95)
        
        let label = UILabel(frame: CGRectMake(20, 0, headerView.frame.size.width - 20, headerView.frame.size.height))
        label.text = self.calendarModel.monthStrArray[section]
        label.font = UIFont.boldSystemFontOfSize(16.0)
        label.shadowOffset = CGSizeMake(0, 1)
        label.shadowColor = UIColor.grayColor()
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.whiteColor()
        
        headerView.addSubview(label)
        tableView.sectionHeaderHeight = headerView.frame.size.height
        
        return headerView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // poptip nil
    }

}
