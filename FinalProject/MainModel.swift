//
//  MainModel.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/4/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import Foundation

class MainModel {
    public var userData:[Stock]

    
    init (){userData = [Stock]()
    }
    
    public func isUnique (stock: Stock?) -> Bool {
        if stock == nil {return false}
        for x in userData { if x.symbol == stock!.symbol {return false} }
        return true
    }
    
    public func addStock(stock: Stock){
        if userData.isEmpty {
            
            
            
            userData.append(stock)
            print("added stock sucessfully!")
            return
        }
        else {for x in userData {if x.symbol == stock.symbol {return}}
            userData.append(stock)
        }
        
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