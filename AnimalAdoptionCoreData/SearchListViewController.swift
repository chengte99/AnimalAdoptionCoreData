//
//  SearchListViewController.swift
//  AnimalAdoptionCoreData
//
//  Created by ChengTeLin on 2017/8/21.
//  Copyright © 2017年 Let'sGoBuildApp. All rights reserved.
//

import UIKit
import Kingfisher
import PKHUD

class SearchListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    var animalSearchList = [Animal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        
        HUD.show(.labeledProgress(title: "讀取中", subtitle: "資料讀取中"), onView: self.view)
        
        if animalSearchList.count == 0{
            //show message when searchList is empty
            
            HUD.hide(afterDelay: 1.0, completion: { (bool) in
                if bool{
                    let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
                    emptyLabel.text = "搜尋條件無配對，請重新搜尋。"
                    emptyLabel.center = self.view.center
                    emptyLabel.textAlignment = NSTextAlignment.center
                    
                    self.view.addSubview(emptyLabel)
                }
            })
            
        }else{
            //show all on table
            
            HUD.hide(afterDelay: 1.0)
            myTableView.isHidden = false
            myTableView.reloadData()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchListTableViewCell
        
        let animal = animalSearchList[indexPath.row]
        
        if let imgString = animal.album_file{
            if let url = URL(string: imgString){
                cell.imgPic.kf.setImage(with: url, placeholder: UIImage(named: "nopic"))
            }
        }
        
        if let shelterName = animal.shelter_name{
            cell.labelShelterName.text = shelterName
        }
        
        if let kind = animal.animal_kind{
            cell.labelAnimalKind.text = kind
        }
        
        if let sex = animal.animal_sex{
            switch sex {
            case "M":
                cell.labelAnimalSex.text = "男生"
            case "F":
                cell.labelAnimalSex.text = "女生"
            default:
                break
            }
        }
        
        if let bodyType = animal.animal_bodytype{
            switch bodyType {
            case "MINI":
                cell.labelAnimalBodyType.text = "迷你"
            case "SMALL":
                cell.labelAnimalBodyType.text = "小型"
            case "MEDIUM":
                cell.labelAnimalBodyType.text = "中型"
            case "BIG":
                cell.labelAnimalBodyType.text = "大型"
            default:
                break
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SearchDetail") as! SearchDetailViewController
        
        if let selectRow = myTableView.indexPathForSelectedRow?.row{
            vc.animal = animalSearchList[selectRow]
        }
        vc.title = "搜尋模式"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
