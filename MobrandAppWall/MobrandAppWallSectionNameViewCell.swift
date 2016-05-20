//
//  MobrandAppWallSectionNameViewCell.swift
//  Mobrand
//
//  Created by Jdira Ovidiu on 09/03/16.
//  Copyright © 2016 OlaMobile. All rights reserved.
//

import UIKit

class MobrandAppWallSectionNameViewCell: UITableViewCell {

    @IBOutlet weak var txtTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(rgba: AppWallColors.APP_WALL_BG)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        txtTitle.setNeedsLayout()
        txtTitle.layoutIfNeeded()
    }

    
    func modelChange(title: String){
        txtTitle.text = title
    }
    
}
