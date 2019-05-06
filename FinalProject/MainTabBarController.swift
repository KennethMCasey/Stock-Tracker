//
//  MainTabBarController.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/4/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    var mainModel:MainModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        mainModel = MainModel()

          // let vcTwo = self.tabBarController?.viewControllers?[1] as! SettingsTableViewController
        
     
        //vcTwo.mainModel = self.mainModel
       
        
       
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       print("beingcalled")
        if let view = segue.destination as? SettingsTableViewController {
            view.mainModel = self.mainModel
        }
        
        if let view = segue.destination as? MyStocksTableViewController {
            view.mainModel = self.mainModel
        }
        
        
    
    }
    

}
