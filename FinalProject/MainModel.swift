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
    
    init (managedContext: NSManagedObjectContext){userData = [Stock]()
        self.managedContext = managedContext
        
        
        let stockFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "StockTemplate")
        var stocks = try? managedContext.fetch(stockFetch)
        if stocks != nil {
            while stocks?.count != 0{
                var loadedStockTemplate =  stocks?.popLast() as! StockTemplate
                let loadedStock = Stock(symbol: loadedStockTemplate.symbol!)
                loadedStock.shareAmounts = loadedStockTemplate.userData as? Dictionary<String, Double>
                loadedStock.generateStockHistory(forInterval: .day)
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
            print("added stock sucessfully!")
            return
 
    }
    
    public func getStockAt(index:Int)->Stock?{
        return userData[index]
    }
    
    public func getStockWith(symbol:String)->Stock?{
        if userData.isEmpty {
            print("empty user data")
            return nil}
        for x in userData {if x.symbol == symbol {
            print("found stock")
            return x}}
        print ("COULD NOT FIND ME")
            return nil
    }
    
    
    
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
            
        case .month:
            print("F")
        }
        return dateArray
    }
    
    public func getStringDate(date:Date)->String{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let cal = Calendar(identifier: .gregorian)
        var newDate = cal.date(from: cal.dateComponents([.year ,.month, .day], from: date))
        var newDateString = format.string(from: newDate!)
        return newDateString
        
    }

    
}
