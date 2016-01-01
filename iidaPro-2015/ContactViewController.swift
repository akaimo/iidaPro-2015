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
        self.firstTextView.text = self.selectOfficeText()
    }
    
    private func selectOfficeText() -> String? {
        let areaData: [String:AnyObject]? = NSUserDefaults.standardUserDefaults().objectForKey("district") as? [String:AnyObject]
        guard let data = areaData else { return nil }
        guard let office = data["office"] as? String else { return nil }
        
        var text: String?
        switch office {
        case "南部": text = "南部生活環境事業所 044-266-5747"
        case "川崎": text = "川崎生活環境事業所 044-541-2043"
        case "中原": text = "中原生活環境事業所 044-411-9220"
        case "宮前": text = "宮前生活環境事業所 044-866-9131"
        case "多摩": text = "多摩生活環境事業所 044-933-4111"
        default: break
        }
        
        return text
    }
    
}
