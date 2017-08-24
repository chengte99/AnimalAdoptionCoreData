//
//  NewestAnimalViewController.swift
//  AnimalAdoptionCoreData
//
//  Created by ChengTeLin on 2017/8/21.
//  Copyright © 2017年 Let'sGoBuildApp. All rights reserved.
//

import UIKit
import SwiftyJSON
import PKHUD
import Kingfisher

class NewestAnimalViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var newestAnimalInfo = [Animal]()
    
    var refresh: UIRefreshControl?
    
    var currentDate: Date?
    var currentDateString = ""
    
    var runTimes = 1
    
    var parentNavigationController: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        let itemSizeWidth = UIScreen.main.bounds.width / 2 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0)
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        layout.itemSize = CGSize(width: itemSizeWidth, height: itemSizeWidth + 50)
        myCollectionView.collectionViewLayout = layout
        
        currentDate = Date()
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        currentDateString = dateFormatter.string(from: currentDate!)
        //        print(currentDateString)
        
        refresh = UIRefreshControl()
        refresh?.addTarget(self, action: #selector(NewestAnimalViewController.dropdownRefresh), for: .valueChanged)
        myCollectionView.addSubview(refresh!)
        
        loadAPI()
    }
    
    func dropdownRefresh(){
        runTimes = 1
        loadAPI()
        refresh?.endRefreshing()
    }
    
    func loadAPI(){
        HUD.show(.labeledProgress(title: "讀取中", subtitle: "正在讀取資料中"), onView: self.view)
        APIManager.shared.getAnimalAPI { (json) in
            if json != nil{
                //                print(json)
                if let results = json.array{
                    repeat{
                        //                        print("##### runtime = \(self.runTimes)")
                        if self.runTimes != 1{
                            //                            print("##### change currentDate, runtime = \(self.runTimes)")
                            self.currentDate = Calendar.current.date(byAdding: .day, value: -1, to: self.currentDate!)
                            var dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            self.currentDateString = dateFormatter.string(from: self.currentDate!)
                        }
                        
                        for result in results{
                            if self.newestAnimalInfo.count == 10{
                                HUD.hide(afterDelay: 1.0)
                                //                                print("##### if self.newestAnimalInfo.count == 10, return")
                                return
                            }else{
                                if let animalOpenDate = result["animal_opendate"].string{
                                    //if opendate equal today
                                    if animalOpenDate == self.currentDateString{
                                        //                                        print("##### animalDate have \(animalOpenDate)")
                                        let aNewAnimal = Animal.init(json: result)
                                        self.newestAnimalInfo.append(aNewAnimal)
                                        self.myCollectionView.reloadData()
                                    }
                                }
                            }
                        }
                        self.runTimes += 1
                    }while self.newestAnimalInfo.count < 10
                    
                }
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newestAnimalInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! NewestAnimalCollectionViewCell
        
        let animal = newestAnimalInfo[indexPath.row]
        
        if let imgString = animal.album_file{
            if let url = URL(string: imgString){
                //                cell.imgPic.layer.cornerRadius = cell.imgPic.frame.size.width / 2
                //                cell.imgPic.layer.borderWidth = 1.0
                //                cell.imgPic.layer.borderColor = UIColor.white.cgColor
                //                cell.imgPic.clipsToBounds = true
                
                cell.imgPic.kf.setImage(with: url, placeholder: UIImage(named: "nopic"))
            }
        }
        
        if let openDate = animal.animal_opendate{
            cell.labelOpenDate.text = openDate
        }
        
        if let sex = animal.animal_sex{
            switch sex {
            case "M":
                cell.labelSex.text = "男生"
                cell.labelSex.textColor = UIColor.blue
            case "F":
                cell.labelSex.text = "女生"
                cell.labelSex.textColor = UIColor.red
            default:
                cell.labelSex.text = "未分類"
            }
        }
        
        if let area = animal.animal_area_pkid{
            cell.labelAddress.text = AREA_ARRAY[area]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AnimalDetail") as! AnimalDetailViewController
        
        if let selectitems = myCollectionView.indexPathsForSelectedItems{
            let selectitem = selectitems[0]
            vc.animal = newestAnimalInfo[selectitem.row]
        }
        vc.title = "新開放認養"
        
        parentNavigationController?.pushViewController(vc, animated: true)
        
        //        performSegue(withIdentifier: "showAnimalDetail", sender: self)
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "showAnimalDetail"{
    //            if let dvc = segue.destination as? AnimalDetailViewController{
    //                if let selectitems = myCollectionView.indexPathsForSelectedItems{
    //                    let selectitem = selectitems[0]
    //                    dvc.animal = newestAnimalInfo[selectitem.row]
    //                    
    //                }
    //            }
    //        }
    //    }
    
}
