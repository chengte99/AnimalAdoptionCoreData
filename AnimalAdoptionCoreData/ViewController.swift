//
//  ViewController.swift
//  AnimalAdoptionCoreData
//
//  Created by ChengTeLin on 2017/8/21.
//  Copyright © 2017年 Let'sGoBuildApp. All rights reserved.
//

import UIKit
import PageMenu
import CNPPopupController

class ViewController: UIViewController, CNPPopupControllerDelegate {
    
    var pageMenu: CAPSPageMenu?
    
    var popupController: CNPPopupController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "寵物認養"
        
        var controllerArray : [UIViewController] = []
        
        let controller1 : NewestAnimalViewController = self.storyboard?.instantiateViewController(withIdentifier: "NewestAnimalViewController") as! NewestAnimalViewController
        //        controller1.view.backgroundColor = .red
        controller1.title = "新開放認養"
        controller1.parentNavigationController = self.navigationController
        controllerArray.append(controller1)
        
        let controller2 : SearchViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        //        controller2.view.backgroundColor = .orange
        controller2.title = "搜尋模式"
        controller2.parentNavigationController = self.navigationController
        controllerArray.append(controller2)
        
        let controller3 : FavoriteAnimalViewController = self.storyboard?.instantiateViewController(withIdentifier: "FavoriteAnimalViewController") as! FavoriteAnimalViewController
        //        controller3.view.backgroundColor = .green
        controller3.title = "我的收藏"
        controller3.parentNavigationController = self.navigationController
        controllerArray.append(controller3)
        
        var parameters: [CAPSPageMenuOption] = [
            .scrollMenuBackgroundColor(UIColor.black),
            .selectionIndicatorColor(UIColor.orange),
            .selectedMenuItemLabelColor(UIColor.orange),
            .unselectedMenuItemLabelColor(UIColor.white),
            .menuHeight(40.0),
        ]
        
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: 0.0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64), pageMenuOptions: parameters)
        
        self.view.addSubview(pageMenu!.view)
    }

    @IBAction func infoAction(_ sender: UIBarButtonItem) {
        showPopupWithStyle(.centered)
    }
    
    func showPopupWithStyle(_ popupStyle: CNPPopupStyle){
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        paragraphStyle.alignment = NSTextAlignment.center
        
        let title = NSAttributedString(string: "關於寵物認養!", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 24), NSParagraphStyleAttributeName: paragraphStyle])
        let lineOne = NSAttributedString(string: "資料來源由行政院農業委員會資料開放平台所提供，如有疑問可進去下方網站連結。", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 18), NSParagraphStyleAttributeName: paragraphStyle])
        
        let webButton = CNPPopupButton.init(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        webButton.backgroundColor = UIColor(red:0.67, green:0.47, blue:0.26, alpha:1.0)
        webButton.setTitle("官方網站", for: UIControlState())
        webButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        webButton.setTitleColor(UIColor.white, for: UIControlState())
        webButton.layer.cornerRadius = 4;
        webButton.selectionHandler = { (button) -> Void in
            if let url = URL(string: OPEN_DATA){
                if #available(iOS 10.0, *) {
                    let options = [UIApplicationOpenURLOptionUniversalLinksOnly: false]
                    UIApplication.shared.open(url, options: options, completionHandler: nil)
                }else {
                    UIApplication.shared.openURL(url)
                }
            }
            print("#### OPEN WEBSITE ####")
        }
        
        let button = CNPPopupButton.init(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle("關閉", for: UIControlState())
        button.backgroundColor = UIColor.init(colorLiteralRed: 0.46, green: 0.8, blue: 1.0, alpha: 1.0)
        button.layer.cornerRadius = 4;
        button.selectionHandler = { (button) -> Void in
            self.popupController?.dismiss(animated: true)
        }
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0;
        titleLabel.attributedText = title
        
        let lineOneLabel = UILabel()
        lineOneLabel.numberOfLines = 0;
        lineOneLabel.attributedText = lineOne;
        
        let popupController = CNPPopupController(contents:[titleLabel, lineOneLabel, webButton, button])
        popupController.theme = CNPPopupTheme.default()
        popupController.theme.popupStyle = popupStyle
        popupController.delegate = self
        self.popupController = popupController
        popupController.present(animated: true)
    }

}

