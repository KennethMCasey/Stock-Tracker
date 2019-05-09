//
//  AddStockDetailModel.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/5/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import Foundation

class AddStockDetailModel {
    var mainModel:MainModel
    
    init(mainModel:MainModel) {
        self.mainModel = mainModel
    }
    
    public func ValidateNumberOfShares(num: String?) -> Bool{
        if num == nil {return false}
        let theValue = Double(num!)
        if let theActualValue = theValue { return (theActualValue > 0.0)}
        return false
    }
    
    public func ValidateDateObtained(date: Date?) -> Bool{
        if date == nil {return false}
        return true
    }
    
    public func ValidateUniqueStock(stock: Stock?) -> Bool {
        return stock == nil ? false : mainModel.isUnique(stock: stock!)
        
    }
    
    public func addStock(stock: Stock, numberOfShares:Double, dateObtained:String){
        stock.shareAmounts?.updateValue(numberOfShares, forKey:  dateObtained)
        stock.generateStockHistory(forInterval: .day)
        stock.generateStockHistory(forInterval: .week)
        mainModel.addStock(stock: stock)
    }
}
