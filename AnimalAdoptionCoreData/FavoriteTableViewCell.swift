//
//  FavoriteTableViewCell.swift
//  AnimalAdoptionCoreData
//
//  Created by ChengTeLin on 2017/8/22.
//  Copyright © 2017年 Let'sGoBuildApp. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPic: UIImageView!
    @IBOutlet weak var labelKind: UILabel!
    @IBOutlet weak var labelSex: UILabel!
    @IBOutlet weak var labelShelterName: UILabel!
    @IBOutlet weak var labelBodyType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
