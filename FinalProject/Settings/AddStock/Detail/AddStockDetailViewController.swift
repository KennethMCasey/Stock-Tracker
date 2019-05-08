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
        
        //inatalizing model
        addStockDetailModel = AddStockDetailModel(mainModel: mainModel!)
        
        //setting up lable
        lblSymbol.text = stock?.symbol
        
        //setting up date dial
        dialDate.datePickerMode = .date
        dialDate.minimumDate = Date(timeIntervalSinceNow: TimeInterval(-630700000))
        dialDate.maximumDate = Date()
        
        //setting up textbox
        txtNumberOfShares.placeholder = "???"

    }
    
    
    @IBAction func AddStockButtonPressed(_ sender: UIButton) {
        if !addStockDetailModel!.ValidateNumberOfShares(num: txtNumberOfShares.text)
        {
            displayStatusMessage(theMessage: "Please enter a number of shares grater than 0...", isError: true)
            return
        }
        if !addStockDetailModel!.ValidateDateObtained(date: dialDate.date)
        {
            displayStatusMessage(theMessage: "Please enter a valid date", isError: true)
            return
        }
        if !addStockDetailModel!.ValidateUniqueStock(stock: stock) {
            displayStatusMessage(theMessage: "Stock Already Exists", isError: true)
            return
        }//error here
        addStock()
       displayStatusMessage(theMessage: "Stock has been added.", isError: false)
    }
    
    
    private func displayStatusMessage(theMessage:String, isError:Bool)
    {
        let alert = UIAlertController(title: isError ? "Error:" : "Action Complete", message: theMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func addStock(){
        let numberOfShares = Double(txtNumberOfShares.text!)
        let dateObtained = mainModel?.getStringDate(date: dialDate.date)
        addStockDetailModel?.addStock(stock: stock!, numberOfShares: numberOfShares!, dateObtained: dateObtained!)
    }
    
    func bumpBack()->Void{ self.navigationController?.popViewController(animated: true)}
}
