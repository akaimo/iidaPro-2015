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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
