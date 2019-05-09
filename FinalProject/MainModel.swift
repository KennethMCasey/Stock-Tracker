//
//  MainModel.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/4/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import Foundation
import CoreData

class MainModel {
    public var userData:[Stock]
    var managedContext: NSManagedObjectContext
    
    init(){
        userData = [Stock]()
        managedContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    }
    
    init (managedContext: NSManagedObjectContext){userData = [Stock]()
        self.managedContext = managedContext
        
        
        let stockFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "StockTemplate")
        var stocks = try? managedContext.fetch(stockFetch)
        if stocks != nil {
            while stocks?.count != 0{
                let loadedStockTemplate =  stocks?.popLast() as! StockTemplate
                let loadedStock = Stock(symbol: loadedStockTemplate.symbol!)
                loadedStock.shareAmounts = loadedStockTemplate.userData as? Dictionary<String, Double>
                loadedStock.generateStockHistory(forInterval: .day)
                loadedStock.generateStockHistory(forInterval: .week)
                userData.append(loadedStock)
            }
        } 
    }
    
    public func isUnique (stock: Stock?) -> Bool {
        if stock == nil {return false}
        for x in userData { if x.symbol == stock!.symbol {return false} }
        return true
        
        
    }
    
    public func addStock(stock: Stock){
        for x in userData {if x.symbol == stock.symbol {return}}
        
        let stockTemplate = NSManagedObject(entity: StockTemplate.entity(), insertInto: managedContext)
        stockTemplate.setValue(stock.symbol, forKey: "symbol")
        stockTemplate.setValue(stock.shareAmounts, forKey: "userData")
        
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        managedContext.refreshAllObjects()
            userData.append(stock)
            return
 
    }
    
    
    public func getStockWith(symbol:String)->Stock?{
        if userData.isEmpty {return nil}
        for x in userData {if x.symbol == symbol {return x}}
        return nil
    }
    
    public func getStockAt(index:Int) ->Stock{ return (userData[index] ) }
    
    public func getValidDatesFor(endDate:Date, interval:StockHistoryInterval) -> [Date]{
        
        
        let cal = Calendar(identifier: .gregorian)
        var dateArray:[Date] = []
        let subtractingInterval = TimeInterval(interval == .day ? 86400 : 604800)
        var addingDate:Date = endDate
        switch interval{
        case .day:
        for _ in 0...6{
            addingDate = addingDate.addingTimeInterval(-subtractingInterval)}
        for _ in 0...6{
            addingDate = addingDate.addingTimeInterval(subtractingInterval)
            dateArray.append(addingDate)
        }
            
        case .week:
            dateArray.append(addingDate)
            while cal.dateComponents([.weekday], from:addingDate).weekday != 6 {addingDate = addingDate.addingTimeInterval(TimeInterval(-86400))}
            dateArray.append(addingDate)
            for _ in 0...4 {
               addingDate = addingDate.addingTimeInterval(-subtractingInterval)
                dateArray.append(addingDate)
            }
            dateArray.reverse()
        }
        return dateArray
    }
    
    public func getStringDate(date:Date)->String{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let cal = Calendar(identifier: .gregorian)
        let newDate = cal.date(from: cal.dateComponents([.year ,.month, .day], from: date))
        let newDateString = format.string(from: newDate!)
        return newDateString
        
    }

    
}
