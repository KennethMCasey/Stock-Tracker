//
//  ModifyStockTableViewController.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/5/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import UIKit

class ModifyStockTableViewController: UITableViewController {
    
    var mainModel : MainModel?
    var modifyStockModel : ModifyStockModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        modifyStockModel = ModifyStockModel(mainModel: mainModel!)
    }

    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return modifyStockModel!.numOfRows()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyStock", for: indexPath) as! ModifyTableViewCell
        cell.lblName.text = modifyStockModel!.getNameFor(row: indexPath.row)
        return cell
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dvc = segue.destination as? ModifyStockDetailViewController {
            dvc.mainModel = self.mainModel
            dvc.symbol = modifyStockModel!.getNameFor(row: (self.tableView.indexPathForSelectedRow?.row)!)
        }
        
    }
    

}
