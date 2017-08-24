//
//  SearchListTableViewCell.swift
//  AnimalAdoptionCoreData
//
//  Created by ChengTeLin on 2017/8/21.
//  Copyright © 2017年 Let'sGoBuildApp. All rights reserved.
//

import UIKit

class SearchListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPic: UIImageView!
    @IBOutlet weak var labelShelterName: UILabel!
    @IBOutlet weak var labelAnimalKind: UILabel!
    @IBOutlet weak var labelAnimalSex: UILabel!
    @IBOutlet weak var labelAnimalBodyType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
