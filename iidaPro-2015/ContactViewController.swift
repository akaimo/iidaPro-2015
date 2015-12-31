//
//  ContactViewController.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/31/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var firstTextView: UITextView!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var secondTextView: UITextView!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var thirdTextView: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func setupView() {
        self.title = "問い合わせ"
        self.view.layer.contents = UIImage(named: "Base")?.CGImage
        Utilities().setNavigation(self)
    }
    
}
