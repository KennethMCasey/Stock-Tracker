//
//  ModifyStockDetailModel.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/6/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import Foundation
class ModifyStockDetailModel{
    var mainModel:MainModel
    
    init(mainModel:MainModel){
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
    
    
    public func updateValue(symbol: String, numberOfShares:Double, dateObtained:Date){
        mainModel.getStockWith(symbol: symbol)?.shareAmounts?.updateValue(numberOfShares, forKey: mainModel.getStringDate(date:dateObtained))
    }
    
}

