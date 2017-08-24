//
//  SearchViewController.swift
//  AnimalAdoptionCoreData
//
//  Created by ChengTeLin on 2017/8/21.
//  Copyright © 2017年 Let'sGoBuildApp. All rights reserved.
//

import UIKit
import PKHUD

class SearchViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var textfieldArea: UITextField!
    @IBOutlet weak var textfieldKind: UITextField!
    @IBOutlet weak var textfieldSex: UITextField!
    @IBOutlet weak var textfieldBodyType: UITextField!
    @IBOutlet weak var textfieldAge: UITextField!
    @IBOutlet weak var buttonSearch: UIButton!
    
    var searchList = [Animal]()
    
    var parentNavigationController: UINavigationController?
    
    var selectedTextfield = 0
    
    var pickerView1 = UIPickerView()
    var pickerView2 = UIPickerView()
    var pickerView3 = UIPickerView()
    var pickerView4 = UIPickerView()
    var pickerView5 = UIPickerView()
    
    var areaIndex = 1
    var kindIndex = 0
    var sexIndex = 0
    var bodyTypeIndex = 0
    var ageIndex = 0
    var kindString = "不限"
    var sexString = "不限"
    var bodyTypeString = "不限"
    var ageString = "不限"
    
    var searchAnimalInfo = [Animal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textfieldArea.delegate = self
        textfieldKind.delegate = self
        textfieldSex.delegate = self
        textfieldBodyType.delegate = self
        textfieldAge.delegate = self
        
        textfieldArea.tag = 1
        textfieldKind.tag = 2
        textfieldSex.tag = 3
        textfieldBodyType.tag = 4
        textfieldAge.tag = 5
        
        buttonSearch.layer.cornerRadius = buttonSearch.frame.size.height / 2
        buttonSearch.clipsToBounds = true
        
        createInputView()
    }
    
    func createInputView(){
        let screenWidth = UIScreen.main.bounds.width
        
        pickerView1 = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
        pickerView1.backgroundColor = UIColor.white
        pickerView1.delegate = self
        pickerView1.dataSource = self
        
        pickerView2 = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
        pickerView2.backgroundColor = UIColor.white
        pickerView2.delegate = self
        pickerView2.dataSource = self
        
        pickerView3 = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
        pickerView3.backgroundColor = UIColor.white
        pickerView3.delegate = self
        pickerView3.dataSource = self
        
        pickerView4 = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
        pickerView4.backgroundColor = UIColor.white
        pickerView4.delegate = self
        pickerView4.dataSource = self
        
        pickerView5 = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
        pickerView5.backgroundColor = UIColor.white
        pickerView5.delegate = self
        pickerView5.dataSource = self
        
        var toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "完成", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SearchViewController.donePicker))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SearchViewController.donePicker))
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textfieldArea.inputView = pickerView1
        textfieldKind.inputView = pickerView2
        textfieldSex.inputView = pickerView3
        textfieldBodyType.inputView = pickerView4
        textfieldAge.inputView = pickerView5
        
        textfieldArea.inputAccessoryView = toolBar
        textfieldKind.inputAccessoryView = toolBar
        textfieldSex.inputAccessoryView = toolBar
        textfieldBodyType.inputAccessoryView = toolBar
        textfieldAge.inputAccessoryView = toolBar
    }
    
    func donePicker(){
        if selectedTextfield == 1{
            textfieldArea.text = AREA_ARRAY[areaIndex]
            textfieldArea.resignFirstResponder()
        }else if selectedTextfield == 2{
            textfieldKind.text = KIND_ARRAY[kindIndex]
            textfieldKind.resignFirstResponder()
        }else if selectedTextfield == 3{
            textfieldSex.text = SEX_ARRAY[sexIndex]
            textfieldSex.resignFirstResponder()
        }else if selectedTextfield == 4{
            textfieldBodyType.text = BODYTYPE_ARRAY[bodyTypeIndex]
            textfieldBodyType.resignFirstResponder()
        }else if selectedTextfield == 5{
            textfieldAge.text = AGE_ARRAY[ageIndex]
            textfieldAge.resignFirstResponder()
        }
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        if textfieldArea.text == "" || textfieldKind.text == "" || textfieldSex.text == "" || textfieldBodyType.text == "" || textfieldAge.text == ""{
            //show warnning message
            let alert = UIAlertController(title: "錯誤", message: "請務必填寫詳細搜尋條件", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }else{
            //get api
            
            transferParameter()
            searchList.removeAll()
            
//            print("### areaIndex = \(areaIndex)")
//            print("### kindString = \(kindString)")
//            print("### sexString = \(sexString)")
//            print("### bodyTypeString = \(bodyTypeString)")
//            print("### ageString = \(ageString)")
            
            APIManager.shared.getSearchAnimalAPI(area: areaIndex, kind: kindString, sex: sexString, bodyType: bodyTypeString, age: ageString, completionHandler: { (json) in
                if json != nil{
//                    print(json)
                    
                    if let results = json.array{
                        for result in results{
                            if let area_id = result["animal_area_pkid"].int{
                                if area_id == self.areaIndex{
                                    let aAnimal = Animal.init(json: result)
                                    self.searchList.append(aAnimal)
                                }
                            }
                        }
                        
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AnimalSearchList") as! SearchListViewController
                        vc.title = "搜尋模式"
                        vc.animalSearchList = self.searchList
                        self.parentNavigationController?.pushViewController(vc, animated: true)
                    }
                }
            })
        }
    }
    
    
    
    func transferParameter(){
        
        kindString = textfieldKind.text!
        
        if textfieldSex.text == "男生"{
            sexString = "M"
        }else if textfieldSex.text == "女生"{
            sexString = "F"
        }else{
            sexString = "不限"
        }
        
        if textfieldBodyType.text == "迷你"{
            bodyTypeString = "MINI"
        }else if textfieldBodyType.text == "小型"{
            bodyTypeString = "SMALL"
        }else if textfieldBodyType.text == "中型"{
            bodyTypeString = "MEDIUM"
        }else if textfieldBodyType.text == "大型"{
            bodyTypeString = "BIG"
        }else{
            bodyTypeString = "不限"
        }
        
        if textfieldAge.text == "幼年"{
            ageString = "CHILD"
        }else if textfieldAge.text == "成年"{
            ageString = "ADULT"
        }else{
            ageString = "不限"
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textfieldArea.isEditing == true{
            selectedTextfield = textfieldArea.tag
        }else if textfieldKind.isEditing == true{
            selectedTextfield = textfieldKind.tag
        }else if textfieldSex.isEditing == true{
            selectedTextfield = textfieldSex.tag
        }else if textfieldBodyType.isEditing == true{
            selectedTextfield = textfieldBodyType.tag
        }else if textfieldAge.isEditing == true{
            selectedTextfield = textfieldAge.tag
        }
        pickerView1.reloadAllComponents()
        pickerView2.reloadAllComponents()
        pickerView3.reloadAllComponents()
        pickerView4.reloadAllComponents()
        pickerView5.reloadAllComponents()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if selectedTextfield == 1{
            return AREA_ARRAY.count
        }else if selectedTextfield == 2{
            return KIND_ARRAY.count
        }else if selectedTextfield == 3{
            return SEX_ARRAY.count
        }else if selectedTextfield == 4{
            return BODYTYPE_ARRAY.count
        }else if selectedTextfield == 5{
            return AGE_ARRAY.count
        }else{
            return 3
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if selectedTextfield == 1{
            return AREA_ARRAY[row+1]
        }else if selectedTextfield == 2{
            return KIND_ARRAY[row]
        }else if selectedTextfield == 3{
            return SEX_ARRAY[row]
        }else if selectedTextfield == 4{
            return BODYTYPE_ARRAY[row]
        }else if selectedTextfield == 5{
            return AGE_ARRAY[row]
        }else{
            return "TEST"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if selectedTextfield == 1{
            areaIndex = row + 1
        }else if selectedTextfield == 2{
            kindIndex = row
        }else if selectedTextfield == 3{
            sexIndex = row
        }else if selectedTextfield == 4{
            bodyTypeIndex = row
        }else if selectedTextfield == 5{
            ageIndex = row
        }
    }
}
