//
//  SearchDetailViewController.swift
//  AnimalAdoptionCoreData
//
//  Created by ChengTeLin on 2017/8/22.
//  Copyright © 2017年 Let'sGoBuildApp. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData
import PKHUD

class SearchDetailViewController: UIViewController {
    
    @IBOutlet weak var imgPic: UIImageView!
    @IBOutlet weak var labelShelterName: UILabel!
    @IBOutlet weak var labelTel: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelAnimalID: UILabel!
    @IBOutlet weak var labelAnimalSubID: UILabel!
    @IBOutlet weak var labelAnimalKind: UILabel!
    @IBOutlet weak var labelAnimalSex: UILabel!
    @IBOutlet weak var labelAnimalBodyType: UILabel!
    @IBOutlet weak var labelAnimalAge: UILabel!
    @IBOutlet weak var labelAnimalSterilization: UILabel!
    @IBOutlet weak var labelAnimalBacterin: UILabel!
    @IBOutlet weak var labelRemark: UILabel!
    
    var animal: Animal?
    
    var currentImageString: String?
    var currentSexString: String?
    var currentBodyTypeString: String?
    var currentAgeString: String?
    var currentSterilizationString: String?
    var currentBacterinString: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let imgString = animal?.album_file{
            currentImageString = imgString
            if let url = URL(string: imgString){
                imgPic.kf.setImage(with: url, placeholder: UIImage(named: "nopic"))
            }
        }
        
        if let shelterName = animal?.shelter_name{
            labelShelterName.text = shelterName
        }
        
        if let shelterTel = animal?.shelter_tel{
            labelTel.text = shelterTel
        }
        
        if let shelterAddress = animal?.shelter_address{
            labelAddress.text = shelterAddress
        }
        
        if let id = animal?.animal_id{
            labelAnimalID.text = id
        }
        
        if let subId = animal?.animal_subid{
            labelAnimalSubID.text = subId
        }
        
        if let kind = animal?.animal_kind{
            labelAnimalKind.text = kind
        }
        
        if let sex = animal?.animal_sex{
            currentSexString = sex
            switch sex {
            case "M":
                labelAnimalSex.text = "男生"
            case "F":
                labelAnimalSex.text = "女生"
            default:
                break
            }
        }
        
        if let bodyType = animal?.animal_bodytype{
            currentBodyTypeString = bodyType
            switch bodyType {
            case "MINI":
                labelAnimalBodyType.text = "迷你"
            case "SMALL":
                labelAnimalBodyType.text = "小型"
            case "MEDIUM":
                labelAnimalBodyType.text = "中型"
            case "BIG":
                labelAnimalBodyType.text = "大型"
            default:
                break
            }
        }
        
        if let age = animal?.animal_age{
            currentAgeString = age
            switch age {
            case "CHILD":
                labelAnimalAge.text = "幼年"
            case "ADULT":
                labelAnimalAge.text = "成年"
            default:
                break
            }
        }
        
        if let sterilization = animal?.animal_sterilization{
            currentSterilizationString = sterilization
            switch sterilization {
            case "T":
                labelAnimalSterilization.text = "是"
            case "F":
                labelAnimalSterilization.text = "否"
            case "N":
                labelAnimalSterilization.text = "未提供"
            default:
                break
            }
        }
        
        if let bacterin = animal?.animal_bacterin{
            currentBacterinString = bacterin
            switch bacterin {
            case "T":
                labelAnimalBacterin.text = "是"
            case "F":
                labelAnimalBacterin.text = "否"
            case "N":
                labelAnimalBacterin.text = "未提供"
            default:
                break
            }
        }
        
        if let remark = animal?.animal_remark{
            labelRemark.text = remark
        }
        
        setDefaultNavigationButton()
    }
    
    func setDefaultNavigationButton(){
        //        let btn1 = UIButton(type: .custom)
        //        btn1.setImage(UIImage(named: "icons8-hearts-25"), for: .normal)
        //        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        //        btn1.addTarget(self, action: #selector(AnimalDetailViewController.checkFavorite), for: .touchUpInside)
        //        let item1 = UIBarButtonItem(customView: btn1)
        
        //        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        let item1 = UIBarButtonItem(image: UIImage(named: "icons8-hearts-25"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(AnimalDetailViewController.checkFavorite))
        
        self.navigationItem.setRightBarButton(item1, animated: true)
        
        let appDel = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDel?.persistentContainer.viewContext else { return }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "animal_id = %@", labelAnimalID.text!)
        
        do{
            let results = try context.fetch(request)
            if results.count > 0{
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "icons8-hearts_filled-25")
            }else{
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "icons8-hearts-25")
            }
        }catch{
            print("#### Set Default Error")
        }
    }
    
    func checkFavorite(){
        let appDel = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDel?.persistentContainer.viewContext else { return }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "animal_id = %@", labelAnimalID.text!)
        
        do{
            let results = try context.fetch(request)
            if results.count > 0{
                print("### Have, so delete this favorite ")
                HUD.flash(.labeledSuccess(title: "移除", subtitle: "已成功移除我的收藏"), delay: 1)
                
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "icons8-hearts-25")
                for result in results{
                    if let aFavorite = result as? Favorite{
                        context.delete(aFavorite)
                        appDel?.saveContext()
                    }
                }
            }else{
                print("### No have, so add this favorite ")
                HUD.flash(.labeledSuccess(title: "加入", subtitle: "已成功加入我的收藏"), delay: 1)
                
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "icons8-hearts_filled-25")
                let aFavorite = NSEntityDescription.insertNewObject(forEntityName: "Favorite", into: context)
                aFavorite.setValue(labelAnimalID.text, forKey: "animal_id")
                aFavorite.setValue(currentImageString, forKey: "album_file")
                aFavorite.setValue(labelShelterName.text, forKey: "shelter_name")
                aFavorite.setValue(labelTel.text, forKey: "shelter_tel")
                aFavorite.setValue(labelAddress.text, forKey: "shelter_address")
                aFavorite.setValue(labelAnimalSubID.text, forKey: "animal_subid")
                aFavorite.setValue(labelAnimalKind.text, forKey: "animal_kind")
                aFavorite.setValue(currentSexString, forKey: "animal_sex")
                aFavorite.setValue(currentBodyTypeString, forKey: "animal_bodytype")
                aFavorite.setValue(currentAgeString, forKey: "animal_age")
                aFavorite.setValue(currentSterilizationString, forKey: "animal_sterilization")
                aFavorite.setValue(currentBacterinString, forKey: "animal_bacterin")
                aFavorite.setValue(labelRemark.text, forKey: "animal_remark")
                appDel?.saveContext()
            }
        }catch{
            print("Chech Favorite Error")
        }
        
    }

}
