//
//  FavoriteAnimalViewController.swift
//  AnimalAdoptionCoreData
//
//  Created by ChengTeLin on 2017/8/21.
//  Copyright © 2017年 Let'sGoBuildApp. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class FavoriteAnimalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    var myFavoriteList = [MyFavorite]()
    
    var parentNavigationController: UINavigationController?
    var emptyLabel = UILabel()
    
    var refresh: UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        
        emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        emptyLabel.text = "我的收藏尚無任何資料。"
        emptyLabel.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 - 40)
        emptyLabel.textAlignment = NSTextAlignment.center
        emptyLabel.isHidden = true
            
        self.view.addSubview(emptyLabel)
        
        refresh = UIRefreshControl()
        refresh?.addTarget(self, action: #selector(NewestAnimalViewController.dropdownRefresh), for: .valueChanged)
        myTableView.addSubview(refresh!)
    }
    
    func dropdownRefresh(){
        viewDidAppear(true)
        refresh?.endRefreshing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        print("#### viewWillAppear")
        loadLocalData()
        
        if myFavoriteList.count == 0{
            //show message when searchList is empty
            
            emptyLabel.isHidden = false
            myTableView.isHidden = true
            myTableView.reloadData()
            
        }else{
            //show all on table
            
            emptyLabel.isHidden = true
            myTableView.isHidden = false
            myTableView.reloadData()
        }
    }
    
    func loadLocalData(){
        myFavoriteList.removeAll()
        
        let appDel = UIApplication.shared.delegate as? AppDelegate
        guard let context = appDel?.persistentContainer.viewContext else { return }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorite")
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            if results.count > 0{
                for result in results{
                    if let aFavorite = result as? Favorite{
                        guard let id = aFavorite.animal_id else{ return }
                        guard let subid = aFavorite.animal_subid else{ return }
                        guard let kind = aFavorite.animal_kind else{ return }
                        guard let sex = aFavorite.animal_sex else{ return }
                        guard let bodytype = aFavorite.animal_bodytype else{ return }
                        guard let age = aFavorite.animal_age else{ return }
                        guard let sterilization = aFavorite.animal_sterilization else{ return }
                        guard let bacterin = aFavorite.animal_bacterin else{ return }
                        guard let remark = aFavorite.animal_remark else{ return }
                        guard let shelter = aFavorite.shelter_name else{ return }
                        guard let image = aFavorite.album_file else{ return }
                        guard let address = aFavorite.shelter_address else{ return }
                        guard let tel = aFavorite.shelter_tel else{ return }
                        
                        let aMyFavorite = MyFavorite.init(id: id, subid: subid, kind: kind, sex: sex, bodytype: bodytype, age: age, sterilization: sterilization, bacterin: bacterin, remark: remark, shelter: shelter, image: image, address: address, tel: tel)
                        myFavoriteList.append(aMyFavorite)
                    }
                }
            }
        }catch{
            print("Load local data Error")
        }
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFavoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FavoriteTableViewCell
        
        let aFavorite = myFavoriteList[indexPath.row]
        
        if let imgString = aFavorite.album_file{
            if let url = URL(string: imgString){
                cell.imgPic.kf.setImage(with: url, placeholder: UIImage(named: "nopic"))
            }
        }
        
        if let shelter = aFavorite.shelter_name{
            cell.labelShelterName.text = shelter
        }
        
        if let kind = aFavorite.animal_kind{
            cell.labelKind.text = kind
        }
        
        if let sex = aFavorite.animal_sex{
            switch sex {
            case "M":
                cell.labelSex.text = "男生"
            case "F":
                cell.labelSex.text = "女生"
            default:
                break
            }
        }
        
        if let bodyType = aFavorite.animal_bodytype{
            switch bodyType {
            case "MINI":
                cell.labelBodyType.text = "迷你"
            case "SMALL":
                cell.labelBodyType.text = "小型"
            case "MEDIUM":
                cell.labelBodyType.text = "中型"
            case "BIG":
                cell.labelBodyType.text = "大型"
            default:
                break
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FavoriteDetail") as! FavoriteDetailViewController
        
        if let selectRow = myTableView.indexPathForSelectedRow?.row{
            vc.animal = myFavoriteList[selectRow]
        }
        vc.title = "我的收藏"
        
        parentNavigationController?.pushViewController(vc, animated: true)
    }

}
