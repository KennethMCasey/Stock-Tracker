//
//  StockData.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/2/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import Foundation



class Stock{
    public var symbol:String?
    public var companyName:String?
    public var shareAmounts:Dictionary<String, Double>?
    public var stockValueHistory:Dictionary<StockHistoryInterval,StockHistory>?
    
    init(symbol: String){
        self.symbol = symbol
        shareAmounts = Dictionary<String,Double>()
        stockValueHistory = Dictionary<StockHistoryInterval,StockHistory>()
    }
    
    init(symbol: String, companyName:String){
        self.symbol = symbol
        self.companyName = companyName
        shareAmounts = Dictionary<String,Double>()
        stockValueHistory = Dictionary<StockHistoryInterval,StockHistory>()
        }
    
    public func generateStockHistory(forInterval: StockHistoryInterval){
        stockValueHistory?.updateValue(StockHistory(companySymbol: symbol!, interval: forInterval) , forKey: forInterval)
    }
    
    
    
   private func amountOfSharesForDate(date: Date) -> Double{
        //this function will take shareAmounts.sorted() to organize the date keys.
        //it will look to see if the date entered is a key.
        //if the date that is entered is a key then you can return the value from the dictonary
        //if the date is not a key, you will need to return the value of the closest date before date in the dictonary
    let stringDate = getStringDate(date: date)
    var theKeys = shareAmounts?.keys.sorted()
    
    if shareAmounts![stringDate] != nil {return shareAmounts![stringDate]!}
    else if stringDate < theKeys![0] {return 0}
    else if stringDate > theKeys![(theKeys?.count)!-1] {return shareAmounts![theKeys![(theKeys?.count)!-1]]!}
    else {
        for i in 0..<(theKeys?.count)! {
            if (stringDate > theKeys![i]) {return shareAmounts![theKeys![i]]!}
                                        }
    }
    return Double.nan
    }
    
    
    
    public func valueOfSharesForDate(date: Date) -> Double {
       
       
        
        
        if stockValueHistory![.day] == nil {
            print("hello me here i should not be here lol")
            stockValueHistory?.updateValue(StockHistory(companySymbol: symbol!, interval: .day), forKey: .day)}
        var actualDate = date
        let cal = Calendar(identifier: .gregorian)
         let hourComponent = cal.component(.hour, from: Date())
        
        let todayComponents:DateComponents = cal.dateComponents([.day, .month], from: Date())
        let dateComponents = cal.dateComponents([.day, .month], from: date)
        
        
       while cal.isDateInWeekend(actualDate){actualDate = actualDate.addingTimeInterval(TimeInterval(86400))}
        var stringDate = getStringDate(date: actualDate)
        if String(hourComponent) < "5" && todayComponents == dateComponents {
            stringDate = getStringDate(date: actualDate.addingTimeInterval(TimeInterval(-86400)))
            return  (stockValueHistory?[.day]?.history![stringDate])! * amountOfSharesForDate(date: date)}
        return  (stockValueHistory?[.day]?.history![stringDate])! * amountOfSharesForDate(date: date)
        
        
        
    }
    
    public func amountOfSharesForWeek(date: Date) -> Double
    {
        
        if stockValueHistory![.week] == nil {
            print("hello me here i should not be here lol")
        }
        
         let cal = Calendar(identifier: .gregorian)
        var actualDate = date
        var runningTotalOfShares = 0.0
        var numDaysWithShares = 0.0
        
        var stringDate = getStringDate(date: actualDate)
        var theKeys = shareAmounts?.keys.sorted()
        
        
        if shareAmounts![stringDate] != nil {
            runningTotalOfShares += shareAmounts![stringDate]!
            numDaysWithShares += 1
            print("found date with shares!")
        }
            actualDate = actualDate.addingTimeInterval(TimeInterval(-86400))
            stringDate = getStringDate(date: actualDate)
        
        while cal.dateComponents([.weekday], from:actualDate).weekday != 6 {if shareAmounts![stringDate] != nil {
            runningTotalOfShares += shareAmounts![stringDate]!
            numDaysWithShares += 1
            }
            actualDate = actualDate.addingTimeInterval(TimeInterval(-86400))
            stringDate = getStringDate(date: actualDate)
            print("found date with shares!")
        }
        
        return numDaysWithShares != 0.0 ? runningTotalOfShares / numDaysWithShares : 0
        
        }
    
    
    public func valueOfSharesForWeek(date:Date) -> Double{
        let stringDate = getStringDate(date: date)
        let theKeys = stockValueHistory![.week]?.history?.keys.sorted()
        for i in 0...(theKeys?.count)!-1 {
            if stringDate <= theKeys![(theKeys?.count)! - i-1] {
                print("found key!")
                return (stockValueHistory![.week]?.history![theKeys![(theKeys?.count)! - i-1]])! * amountOfSharesForWeek(date:date)
            }
            
        }
       return (stockValueHistory![.week]?.history![theKeys![(theKeys?.count)!-1]])! * amountOfSharesForWeek(date:date)}
    
    public func amountOfSharesForMonth(date:Date) -> Double{
        
        if stockValueHistory![.month] == nil {
            print("hello me here i should not be here lol")
        }
        
        let cal = Calendar(identifier: .gregorian)
        var actualDate = date
        var runningTotalOfShares = 0.0
        var numDaysWithShares = 0.0
        
        
        
        
        
        
        
        return 0}
    
    public func valueOfSharesForMonth(date:Date) -> Double{return 0}
    
    
    
    public func getStringDate(date:Date)->String{
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let cal = Calendar(identifier: .gregorian)
        var newDate = cal.date(from: cal.dateComponents([.year ,.month, .day], from: date))
        var newDateString = format.string(from: newDate!)
        return newDateString
        
    }
    
    
    
    
}
