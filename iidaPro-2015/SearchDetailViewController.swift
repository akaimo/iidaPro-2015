//
//  SearchDetailViewController.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/26/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreImageView1: UIImageView!
    @IBOutlet weak var genreImageView2: UIImageView!
    @IBOutlet weak var genreImageView3: UIImageView!
    @IBOutlet weak var detailTextView: UITextView!
    
    var trashData: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
