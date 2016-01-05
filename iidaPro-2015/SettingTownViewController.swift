//
//  SettingTownViewController.swift
//  iidaPro-2015
//
//  Created by akaimo on 1/4/16.
//  Copyright © 2016 akaimo. All rights reserved.
//

import UIKit

class SettingTownViewController: UIViewController {
    @IBOutlet weak var townTableView: UITableView!
    var townName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.townName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
