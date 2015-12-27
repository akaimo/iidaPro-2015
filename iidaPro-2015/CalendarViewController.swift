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
        return 55.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // poptip nil
    }

}
