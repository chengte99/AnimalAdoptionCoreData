//
//  APIManager.swift
//  AnimalAdoptionCoreData
//
//  Created by ChengTeLin on 2017/8/21.
//  Copyright © 2017年 Let'sGoBuildApp. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIManager{
    
    static let shared = APIManager()
    
    let baseURL = NSURL(string: ANIMAL_API)
    var pathAnd = "+and+"
    var pathString: String = ""
    
    func getAnimalAPI(completionHandler: @escaping (JSON) -> Void){
        if let url = URL(string: ANIMAL_API){
            Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding(), headers: nil).responseJSON(completionHandler: { (response) in
                switch response.result{
                case .success(let value):
                    let jsonData = JSON(value)
                    completionHandler(jsonData)
                case .failure:
                    completionHandler(nil)
                }
            })
        }
    }
    
    func getSearchAnimalAPI(area: Int, kind: String, sex: String, bodyType: String, age: String, completionHandler: @escaping (JSON) -> Void){
        pathString = ""
        
        if area != 1{
            pathString += "animal_area_pkid+like+\(area)"
        }
        
        if kind != "不限" && area != 1{
            pathString += pathAnd + "animal_kind+like+\(kind)"
        }else if kind != "不限"{
            pathString += "animal_kind+like+\(kind)"
        }
        
        if sex != "不限" && (kind != "不限" || area != 1){
            pathString += pathAnd + "animal_sex+like+\(sex)"
        }else if sex != "不限"{
            pathString += "animal_sex+like+\(sex)"
        }
        
        if bodyType != "不限" && (kind != "不限" || area != 1 || sex != "不限"){
            pathString += pathAnd + "animal_bodytype+like+\(bodyType)"
        }else if bodyType != "不限"{
            pathString += "animal_bodytype+like+\(bodyType)"
        }
        
        if age != "不限" && (kind != "不限" || area != 1 || sex != "不限" || bodyType != "不限"){
            pathString += pathAnd + "animal_age+like+\(age)"
        }else if age != "不限"{
            pathString += "animal_age+like+\(age)"
        }
        
        let urlString: String = SEARCH_API + pathString
        
        print("###### pathstring = \(pathString)")
        print("###### urlString = \(urlString)")
        
        if pathString != ""{
            
            if let urlStringEncode = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
                if let url = URL(string: urlStringEncode){
                    Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding(), headers: nil).responseJSON(completionHandler: { (response) in
                        switch response.result{
                        case .success(let value):
                            let jsonData = JSON(value)
                            completionHandler(jsonData)
                        case .failure:
                            completionHandler(nil)
                        }
                    })
                }
            }
            
        }else{
            if let url = URL(string: ANIMAL_API){
                Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding(), headers: nil).responseJSON(completionHandler: { (response) in
                    switch response.result{
                    case .success(let value):
                        let jsonData = JSON(value)
                        completionHandler(jsonData)
                    case .failure:
                        completionHandler(nil)
                    }
                })
            }
        }
    }
    
    
}
