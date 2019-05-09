//
//  ModifyStockDetailModel.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/6/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import Foundation
import CoreData

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
        
        let stockFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "StockTemplate")
        var stocks = try? mainModel.managedContext.fetch(stockFetch)
        if stocks != nil {
            while stocks?.count != 0{
                let loadedStockTemplate =  stocks?.popLast() as! StockTemplate
                if loadedStockTemplate.symbol == symbol {
                    mainModel.managedContext.delete(loadedStockTemplate)
                    
                    let savingStockTemplate = NSManagedObject(entity: StockTemplate.entity(), insertInto: mainModel.managedContext)
                    savingStockTemplate.setValue(symbol, forKey: "symbol")
                    savingStockTemplate.setValue(mainModel.getStockWith(symbol: symbol)!.shareAmounts, forKey: "userData")
                    

                    do {
                        try mainModel.managedContext.save()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                    
                    
                }
                mainModel.managedContext.refreshAllObjects()
                
            }
    }
    
}

}
