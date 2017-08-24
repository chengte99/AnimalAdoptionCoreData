//
//  NewestAnimal.swift
//  AnimalAdoptionCoreData
//
//  Created by ChengTeLin on 2017/8/21.
//  Copyright © 2017年 Let'sGoBuildApp. All rights reserved.
//

import Foundation
import SwiftyJSON

class Animal{
    var animal_id: String?
    var animal_subid: String?
    var animal_area_pkid: Int?
    var animal_kind: String?
    var animal_sex: String?
    var animal_bodytype: String?
    var animal_color: String?
    var animal_age: String?
    var animal_sterilization: String?
    var animal_bacterin: String?
    var animal_remark: String?
    var animal_opendate: String?
    var shelter_name: String?
    var album_file: String?
    var shelter_address: String?
    var shelter_tel: String?
    
    init(json: JSON){
        
        self.animal_id = json["animal_id"].string
        self.animal_subid = json["animal_subid"].string
        self.animal_area_pkid = json["animal_area_pkid"].int
        self.animal_kind = json["animal_kind"].string
        self.animal_sex = json["animal_sex"].string
        self.animal_bodytype = json["animal_bodytype"].string
        self.animal_color = json["animal_colour"].string
        self.animal_age = json["animal_age"].string
        self.animal_sterilization = json["animal_sterilization"].string
        self.animal_bacterin = json["animal_bacterin"].string
        self.animal_remark = json["animal_remark"].string
        self.animal_opendate = json["animal_opendate"].string
        self.shelter_name = json["shelter_name"].string
        self.album_file = json["album_file"].string
        self.shelter_address = json["shelter_address"].string
        self.shelter_tel = json["shelter_tel"].string
    }
}
