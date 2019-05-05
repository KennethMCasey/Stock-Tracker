//
//  StockData.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/2/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import Foundation

class Stock {
    private var symbol:String?
    private var companyName:String?
    private var shareAmounts:Dictionary<Date, Double>?
    private var isActive:Bool?
    private var stockValueHistory:Dictionary<StockHistoryInterval,StockHistory>?
    
    public func amountOfSharesForDate(date: Date) -> Double{
        //this function will take shareAmounts.sorted() to organize the date keys.
        //it will look to see if the date entered is a key.
        //if the date that is entered is a key then you can return the value from the dictonary
        //if the date is not a key, you will need to return the value of the closest date before date in the dictonary
        return -1
    }
    
    public func valueOfSharesForDate(date: Date) -> Double {
        return -1
    }
    
    public func amountOfSharesForWeek(date: Date) -> Double
    {return -1}
    
    public func valueOfSharesForWeek(date:Date) -> Double{return 0}
    
    public func amountOfSharesForMonth(date:Date) -> Double{return 0}
    
    public func valueOfSharesForMonth(date:Date) -> Double{return 0}
    
    public func amountOfSharesForYear(date:Date) -> Double{return 0}
    
    public func valueOfSharesForYear(date:Date) -> Double{return 0}
    
    
    
    
    
    
    
}
