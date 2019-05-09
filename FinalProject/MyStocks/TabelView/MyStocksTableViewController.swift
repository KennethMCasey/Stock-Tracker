//
//  MyStocksTableViewController.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/4/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import UIKit
import CoreData

class MyStocksTableViewController: UITableViewController {
    
    var mainModel:MainModel?
    var myStocksModel : MyStocksModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //passing main model here
        if let tab = self.tabBarController as? MainTabBarController {
            mainModel = tab.mainModel }
        myStocksModel = MyStocksModel(mainModel: mainModel!)
    }

    override func viewDidAppear(_ animated: Bool) {
        //reload table view every time is seen
        self.tableView.reloadData()
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myStocksModel?.numOfRows() ?? 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PortfolioValue", for: indexPath) as! PortfolioValueTableViewCell
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Stock", for: indexPath) as! StockTableViewCell
            cell.lblName.text = myStocksModel?.getNameFor(row: indexPath.row)
            return cell
        }
        
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return !(indexPath.row == 0)
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
         
            
            
            let stockFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "StockTemplate")
            var stocks = try? mainModel!.managedContext.fetch(stockFetch)
            if stocks != nil {
                while stocks?.count != 0{
                    let loadedStockTemplate =  stocks?.popLast() as! StockTemplate
                    if loadedStockTemplate.symbol == mainModel?.userData[indexPath.row-1].symbol {
                        mainModel!.managedContext.delete(loadedStockTemplate)
                    }
        }
                
    }
            mainModel?.userData.remove(at: indexPath.row-1)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let actualView = segue.destination as? StockDetailViewController {
        actualView.mainModel = mainModel
            actualView.stockSymbol = myStocksModel?.getNameFor(row: (self.tableView.indexPathForSelectedRow?.row)!)
        }
        
        if let actualView = segue.destination as? PortfolioValueViewController {
            actualView.mainModel = mainModel
        }
    }
    

}
