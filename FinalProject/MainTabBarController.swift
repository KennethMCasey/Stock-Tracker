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
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
    
        mainModel = MainModel(managedContext: managedContext)
    }
    

    
}
