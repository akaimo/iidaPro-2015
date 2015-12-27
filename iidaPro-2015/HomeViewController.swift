//
//  HomeViewController.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/15/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, HomeModelDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var trashImageView: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    
    var homeModel: HomeModel!

    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeModel = HomeModel()
        self.homeModel.delegate = self
        
        self.title  = "ホーム"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.homeModel.updateAreaData()
        self.homeModel.fetchEvent()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.homeModel.fetchWeatherThema()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - HomeModelDelegate
    func setLocation(location: String) {
        self.locationLabel.text = location
    }
    
    func setTrashImage(image: UIImage?) {
        self.trashImageView.image = image
    }
    
    func changeWeatherThema(weather: Weather) {
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
    
    func setEvent(title: String, url: String) {
        self.eventLabel.text = title
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
        case 0: performSegueWithIdentifier("Search", sender: indexPath)
        case 1: vc = self.storyboard?.instantiateViewControllerWithIdentifier("tips") as! TipsViewController
        case 2: vc = self.storyboard?.instantiateViewControllerWithIdentifier("CalendarOld") as! CalendarViewControllerOld
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
