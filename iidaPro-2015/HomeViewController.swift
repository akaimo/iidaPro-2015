//
//  HomeViewController.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/15/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var trashImageView: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    
    var weatherThema: Weather = .Sunny
    var areaData: [String:AnyObject]?

    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title  = "ホーム"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.updateAreaData()
        self.fetchWeatherThema()
        self.setLocation()
        self.setEvent()
        self.setTrashImage()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.changeWeatherThema(self.weatherThema)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Private methods
    private func changeWeatherThema(weather: Weather) {
        self.menuCollectionView.backgroundColor = weather.menuColor()
        self.weatherImageView.image = weather.weatherImage()
        
        switch weather {
        case .Sunny, .Cloudy, .Snowy:
            let gradientLayer: CircleGradientLayer_swift = CircleGradientLayer_swift.init(weather: weather)
            gradientLayer.frame = self.colorView.bounds
            self.colorView.layer.insertSublayer(gradientLayer, atIndex: 0)
            
        case .Rainy:
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = self.colorView.bounds
            gradient.colors = [
                UIColor(red: 71/255.0, green: 117/255.0, blue: 192/255.0, alpha: 1.0).CGColor,
                UIColor(red: 21/255.0, green: 39/255.0, blue: 69/255.0, alpha: 1.0).CGColor
            ]
            self.colorView.layer.insertSublayer(gradient, atIndex: 0)
        }
    }
    
    private func setLocation() {
        guard let areaData = self.areaData else { return }
        self.locationLabel.text = areaData["area"] as? String ?? "NoArea"
    }
    
    private func setEvent() {
        // TODO: set up from api server
        self.eventLabel.text = "年末年始のごみ収集日程のお知らせ"
    }
    
    private func fetchWeatherThema() {
        // TODO: 天気APIから取得
        self.weatherThema = Weather.Snowy
    }
    
    private func updateAreaData() {
        let ud = NSUserDefaults.standardUserDefaults()
        self.areaData = ud.objectForKey("district") as? [String:AnyObject]
    }
    
    private func setTrashImage() {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let weekDay = NSDate().nowWeekday(NSDate())
        let weekdayOriginal = NSDate().weekdayOriginal(NSDate())
        var todayCategory: String = ""
        
        guard let areaData = areaData else { return }
        
        for category in appDelegate.categoryArray_en {
            guard let categoryDate = areaData[category] as? String else { continue }
            
            if weekDay == categoryDate {
                todayCategory = category
                break
            }
        }
        
        var image = UIImage(named: "T_NoImage")
        switch todayCategory {
        case "normal_1", "normal_2":
            image = UIImage(named: "T_Normal")
        case "bottle":
            image = UIImage(named: "T_Can")
        case "plastic":
            image = UIImage(named: "T_Plastic")
        case "mixedPaper":
            image = UIImage(named: "T_Mixed")
        case "bigRefuse_date":
            if weekdayOriginal == areaData["bigRefuse_1"] as! Int || weekdayOriginal == areaData["bigRefuse_2"] as! Int {
                image = UIImage(named: "T_BigRefuse")
            }
        default: break
        }
        
        if todayCategory != "" && weekDay == areaData["bigRefuse_date"] as! String {
            if weekdayOriginal == areaData["bigRefuse_1"] as! Int || weekdayOriginal == areaData["bigRefuse_2"] as! Int {
                switch todayCategory {
                case "normal_1", "normal_2":
                    image = UIImage(named: "T_W_Normal")
                case "bottle":
                    image = UIImage(named: "T_W_Can")
                case "plastic":
                    image = UIImage(named: "T_W_Plastic")
                case "mixedPaper":
                    image = UIImage(named: "T_W_Mixed")
                default: break
                }
            }
        }
        
        self.trashImageView.image = image
    }
    

    // MARK: - UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:MenuCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MenuCollectionViewCell
        let str: String! = NSString(format: "Image-%d", indexPath.row) as String
        cell.menuImageView.image = UIImage(named: str)
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let oneSide = self.menuCollectionView.frame.height * 11/16
        return CGSizeMake(oneSide, oneSide)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(20.0, 0.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSizeMake(20.0, 0.0)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 20.0
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var vc: UIViewController?
        
        switch indexPath.row {
        case 0: vc = self.storyboard?.instantiateViewControllerWithIdentifier("Search") as! SearchResultViewController
        case 1: vc = self.storyboard?.instantiateViewControllerWithIdentifier("tips") as! TipsViewController
        case 2: vc = self.storyboard?.instantiateViewControllerWithIdentifier("Calendar") as! CalendarViewController
        case 3: vc = self.storyboard?.instantiateViewControllerWithIdentifier("Alarm") as! AlarmViewController
        case 4: vc = self.storyboard?.instantiateViewControllerWithIdentifier("Contact") as! ContactViewController
        case 5: vc = self.storyboard?.instantiateViewControllerWithIdentifier("Setting") as! SettingViewController
        default: break
        }
        
        if let vc = vc {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}
