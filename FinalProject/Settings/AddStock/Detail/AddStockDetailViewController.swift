//
//  AddStockDetailViewController.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/5/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import UIKit

class AddStockDetailViewController: UIViewController {
    var mainModel:MainModel?
    var addStockDetailModel:AddStockDetailModel?
    
    public var stock:Stock?
    @IBOutlet weak var lblSymbol: UILabel!
    @IBOutlet weak var txtNumberOfShares: UITextField!
    @IBOutlet weak var dialDate: UIDatePicker!
    @IBOutlet weak var btnConfirm: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStockDetailModel = AddStockDetailModel(mainModel: mainModel!)
        
        var x = mainModel == nil ? "AddStockDetailViewController mainmodel is nil" : "AddStockDetailViewController mainmodel is  not nil"
        
        print (x)
        lblSymbol.text = stock?.symbol
        
        dialDate.datePickerMode = .date
        dialDate.minimumDate = Date(timeIntervalSinceNow: TimeInterval(-630700000))
        dialDate.maximumDate = Date()
        
        txtNumberOfShares.placeholder = "???"

    }
    
    
    @IBAction func AddStockButtonPressed(_ sender: UIButton) {
        if !addStockDetailModel!.ValidateNumberOfShares(num: txtNumberOfShares.text) {let alert = UIAlertController(title: "Error:", message: "Please enter a number of shares grater than 0...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        } //error here
        if !addStockDetailModel!.ValidateDateObtained(date: dialDate.date) {
            let alert = UIAlertController(title: "Error:", message: "Please enter a valid date", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        } //error here
        if !addStockDetailModel!.ValidateUniqueStock(stock: stock) {
            let alert = UIAlertController(title: "Error:", message: "Stock Already Exists", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }//error here
        addStock()
        let alert = UIAlertController(title: "Action Complete", message: "Stock has been added.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func addStock(){
        let numberOfShares = Double(txtNumberOfShares.text!)
        let dateObtained = dialDate.date
        addStockDetailModel?.addStock(stock: stock!, numberOfShares: numberOfShares!, dateObtained: dateObtained)
    }
    
    func bumpBack()->Void{ self.navigationController?.popViewController(animated: true)}
}
