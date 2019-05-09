//
//  ModifyStockDetailViewController.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/6/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import UIKit

class ModifyStockDetailViewController: UIViewController {

    @IBOutlet weak var lblSymbol: UILabel!
    
    @IBOutlet weak var txtNumOfShares: UITextField!
    
    @IBOutlet weak var dialDate: UIDatePicker!
    
    @IBOutlet weak var btnUpdateValue: UIButton!
    
    var modifyStockDetailModel:ModifyStockDetailModel?
    var mainModel:MainModel?
    var stock:Stock?
    var symbol:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modifyStockDetailModel = ModifyStockDetailModel(mainModel: mainModel!)
        lblSymbol.text = symbol
        txtNumOfShares.placeholder = "???"
        dialDate.datePickerMode = .date
        dialDate.minimumDate = Date(timeIntervalSinceNow: TimeInterval(-11830000))
        dialDate.maximumDate = Date()
        
        
    }
    

    @IBAction func UpdateButtonPressed(_ sender: UIButton) {
        if !modifyStockDetailModel!.ValidateNumberOfShares(num: txtNumOfShares.text)
        {
            displayStatusMessage(theMessage: "Please enter a number of shares grater than 0...", isError: true)
            return
        }
        if !modifyStockDetailModel!.ValidateDateObtained(date: dialDate.date)
        {
            displayStatusMessage(theMessage: "Please enter a valid date", isError: true)
            return
        }
        modifyStock()
        displayStatusMessage(theMessage: "Stock has been added.", isError: false)
    }
    
    
    func modifyStock() {
        let numberOfShares = Double(txtNumOfShares.text!)
        let dateObtained = dialDate.date
        modifyStockDetailModel?.updateValue(symbol: symbol!, numberOfShares: numberOfShares!, dateObtained: dateObtained)
}
    
    private func displayStatusMessage(theMessage:String, isError:Bool)
    {
        let alert = UIAlertController(title: isError ? "Error:" : "Action Complete", message: theMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
