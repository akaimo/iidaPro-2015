//
//  HomeViewController.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/15/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

enum Weather {
    case Sunny, Rainy, Cloudy, Snowy
    
    func menuColor() -> UIColor {
        switch self {
        case .Sunny:
            return UIColor(red: 59/255.0, green: 110/255.0, blue: 212/255.0, alpha: 1.0)
        case .Cloudy:
            return UIColor(red: 97/255.0, green: 100/255.0, blue: 106/255.0, alpha: 1.0)
        case .Rainy:
            return UIColor(red: 74/255.0, green: 144/255.0, blue: 226/255.0, alpha: 1.0)
        case .Snowy:
            return UIColor.blackColor()
        }
    }
}

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    @IBOutlet weak var trashImageView: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    
    var weather: Weather = .Sunny

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // TODO: 天気APIから取得
        self.weather = Weather.Sunny
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.changeWeatherThema(self.weather)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func changeWeatherThema(weather: Weather) {
        self.menuCollectionView.backgroundColor = weather.menuColor()
        
        switch weather {
        case .Sunny:
            let gradientLayer: CircleGradientLayer_swift = CircleGradientLayer_swift.init(weather: .Sunny)
            gradientLayer.frame = self.colorView.bounds
            self.colorView.layer.insertSublayer(gradientLayer, atIndex: 0)
            
            self.weatherImageView.image = UIImage(named: "Sunny")
            
        case .Cloudy:
            print("cloudy")
        case .Rainy:
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = self.colorView.bounds
            gradient.colors = [
                UIColor(red: 71/255.0, green: 117/255.0, blue: 192/255.0, alpha: 1.0).CGColor,
                UIColor(red: 21/255.0, green: 39/255.0, blue: 69/255.0, alpha: 1.0).CGColor
            ]
            self.colorView.layer.insertSublayer(gradient, atIndex: 0)
            
            self.weatherImageView.image = UIImage(named: "Rainy")
            
        case .Snowy:
            print("snowy")
        }
        self.trashImageView.image = UIImage(named: "T_NoImage")
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
        // TODO: push next page
    }

}
