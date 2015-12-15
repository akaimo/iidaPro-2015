//
//  MenuCollectionViewCell.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/15/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var menuImageView: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
}
