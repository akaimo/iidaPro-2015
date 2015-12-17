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
    
    func weatherImage() -> UIImage? {
        switch self {
        case .Sunny: return UIImage(named: "Sunny")
        case .Cloudy: return UIImage(named: "Cloudy")
        case .Rainy: return UIImage(named: "Rainy")
        case .Snowy: return UIImage(named: "Snowy")
        }
    }
    
    func gradColors() -> [CGFloat]? {
        switch self {
        case .Sunny:
            let colors: [CGFloat] = [
                0/255.0, 207/255.0, 239/255.0, 1.0,
                68/255.0, 169/255.0, 243/255.0, 1.0
            ]
            return colors
        case .Cloudy:
            let colors: [CGFloat] = [
                136/255.0, 141/255.0, 150/255.0, 1.0,
                97/255.0, 100/255.0, 106/255.0, 1.0
            ]
            return colors
        case .Rainy: return nil
        case .Snowy:
            let colors: [CGFloat] = [
                37/255.0, 60/255.0, 99/255.0, 1.0,
                3/255.0, 10/255.0, 21/255.0, 1.0
            ]
            return colors
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
    
    var weatherThema: Weather = .Sunny

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fetchWeatherThema()
        self.setLocation()
        self.setEvent()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.changeWeatherThema(self.weatherThema)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Private methods
    private
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
        self.trashImageView.image = UIImage(named: "T_NoImage")
    }
    
    func setLocation() {
        self.locationLabel.text = "多摩区"
    }
    
    func setEvent() {
        // TODO: set up from api server
        self.eventLabel.text = "年末年始のごみ収集日程のお知らせ"
    }
    
    func fetchWeatherThema() {
        // TODO: 天気APIから取得
        self.weatherThema = Weather.Snowy
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
