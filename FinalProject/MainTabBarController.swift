//
//  MainTabBarController.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/4/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import UIKit
import CoreData


class MainTabBarController: UITabBarController {
    
    var mainModel:MainModel?
    var temp : StockHistory?
   

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        mainModel = MainModel()
    }
    

    
}
