//
//  Constrant.swift
//  AnimalAdoptionCoreData
//
//  Created by ChengTeLin on 2017/8/21.
//  Copyright © 2017年 Let'sGoBuildApp. All rights reserved.
//

import Foundation

let ANIMAL_API: String = "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx"
let SEARCH_API: String = "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx?$top=100&$skip=0&$filter="

let OPEN_DATA: String = "http://data.coa.gov.tw/Query/ServiceDetail.aspx?id=177"

let AREA_ARRAY = [1: "不限", 2: "台北市", 3: "新北市", 4: "基隆市", 5: "宜蘭縣", 6: "桃園市", 7: "新竹縣", 8: "新竹市",
                  9: "苗栗縣", 10: "台中市", 11: "彰化縣", 12: "南投縣", 13: "雲林縣", 14: "嘉義縣",
                  15: "嘉義市", 16: "台南市", 17: "高雄市", 18: "屏東縣", 19: "花蓮縣", 20: "台東縣",
                  21: "澎湖縣", 22: "金門縣", 23: "連江縣"
]

let KIND_ARRAY = ["不限", "狗", "貓"]
let SEX_ARRAY = ["不限", "男生", "女生"]
let BODYTYPE_ARRAY = ["不限", "迷你", "小型", "中型", "大型"]
let AGE_ARRAY = ["不限", "幼年", "成年"]
