//
//  CustomAppWallViewCell.swift
//  Mobrand
//
//  Created by oJdira on 10/05/16.
//  Copyright © 2016 OlaMobile. All rights reserved.
//

import UIKit
import MobrandCore

class CustomAppWallViewCell: UITableViewCell {

    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var txtName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func modelChange(ad: Ad){
        ImageLoader.sharedLoader.imageForUrl(ad.icon) { (image, url) in
            self.imgLogo.image = image!
        }
        
        txtName.text = ad.name
        
    }
    
}
