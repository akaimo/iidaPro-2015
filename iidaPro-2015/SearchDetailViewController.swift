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
    @IBOutlet weak var genreView: UIView!
    @IBOutlet weak var genreImageView1: UIImageView!
    @IBOutlet weak var genreImageView2: UIImageView!
    @IBOutlet weak var genreImageView3: UIImageView!
    @IBOutlet weak var detailTextView: UITextView!
    
    var trashData: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "詳細"
        self.setupView()
    }

    override func viewDidLayoutSubviews() {
        self.detailTextView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    private func setupView() {
        self.view.layer.contents = UIImage(named: "Base")?.CGImage
        
        self.genreView.layer.cornerRadius = 10.0
        self.genreView.layer.masksToBounds = true
        
        guard let data = self.trashData as? TrashCategory else { return }
        self.titleLabel.text = data["title"] as? String
        self.detailTextView.text = data["info"] as? String
        self.detailTextView.textColor = UIColor.whiteColor()
        self.detailTextView.font = UIFont.systemFontOfSize(16)
        
        guard let trashStr = data["allCategory"] as? String else { return }
        let array = trashStr.characters.split("|").map { String($0) }
        let viewArray = [self.genreImageView1, self.genreImageView2, self.genreImageView3]
        for num in 0..<array.count {
            viewArray[num].image = self.selectGenreImage(array[num])
        }
    }
    
    private func selectGenreImage(genre: String) -> UIImage? {
        var img: UIImage?
        
        switch genre {
        case "普通ごみ": img = UIImage(named: "S_Normal")
        case "ミックスペーパー": img = UIImage(named: "S_Mixed")
        case "プラスチック製容器包装": img = UIImage(named: "S_plastic")
        case "小物金属": img = UIImage(named: "S_Metal")
        case "使用済み乾電池": img = UIImage(named: "S_battery")
        case "空き缶・ペットボトル": img = UIImage(named: "C_Can")
        case "空きびん": img = UIImage(named: "C_Can")
        case "粗大ごみ": img = UIImage(named: "S_BigRefuse")
        case "収集しない": img = UIImage(named: "S_No")
        default: break
        }
        
        return img
    }
    
}
