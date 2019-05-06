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
    
    init (){userData = [Stock]() }
    
    public func isUnique (stock: Stock?) -> Bool {
        if stock == nil {return false}
        for x in userData { if x.symbol == stock!.symbol {return false} }
        return true
    }
    
    public func addStock(stock: Stock){
        if userData.isEmpty {userData.append(stock)
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
        if userData.isEmpty {return nil}
        for x in userData {if x.symbol == symbol {return x}}
            return nil
    }
    
    
    
}
