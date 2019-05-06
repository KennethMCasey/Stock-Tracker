//
//  AddStockViewController.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/5/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import UIKit

class AddStockViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    
    
    var mainModel:MainModel?
    var addStockModel:AddStockModel?
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStockModel = AddStockModel()
        
    }
    

    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String?) {
        addStockModel?.loadResults(searchTerm: searchText!){self.tableView.reloadData()}
    }
    
   
    
    
    
    
    //MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (addStockModel?.numResults()) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AddResultsCell", for: indexPath) as? AddStockResultsTableViewCell
        {
            cell.lblSymbol.text = addStockModel?.searchResults![indexPath.row].symbol
           return cell
        }
        
        return UITableViewCell()
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let detailView = segue.destination as? AddStockDetailViewController
        {
            detailView.mainModel = self.mainModel
            detailView.stock = addStockModel?.searchResults![(self.tableView.indexPathForSelectedRow?.row)!]
            
        }
        
    }
    

}
