//
//  SearchCell.swift
//  iidaPro-2015
//
//  Created by akaimo on 12/26/15.
//  Copyright © 2015 akaimo. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var trashImageView: UIImageView!
    @IBOutlet weak var trashLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.trashImageView.image = nil
        self.trashLabel.text = nil
    }
    
}
