//
//  Favorite.swift
//  AnimalAdoptionCoreData
//
//  Created by ChengTeLin on 2017/8/22.
//  Copyright © 2017年 Let'sGoBuildApp. All rights reserved.
//

import Foundation

class MyFavorite{
    var animal_id: String?
    var animal_subid: String?
    var animal_kind: String?
    var animal_sex: String?
    var animal_bodytype: String?
    var animal_age: String?
    var animal_sterilization: String?
    var animal_bacterin: String?
    var animal_remark: String?
    var shelter_name: String?
    var album_file: String?
    var shelter_address: String?
    var shelter_tel: String?
    
    init(id: String, subid: String, kind: String, sex: String, bodytype: String, age: String, sterilization: String, bacterin: String, remark: String, shelter: String, image: String, address: String, tel: String){
        
        self.animal_id = id
        self.animal_subid = subid
        self.animal_kind = kind
        self.animal_sex = sex
        self.animal_bodytype = bodytype
        self.animal_age = age
        self.animal_sterilization = sterilization
        self.animal_bacterin = bacterin
        self.animal_remark = remark
        self.shelter_name = shelter
        self.album_file = image
        self.shelter_address = address
        self.shelter_tel = tel
    }
    
}
