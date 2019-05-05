//
//  StockHistory.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/2/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import Foundation

class StockHistory{
    init(companySymbol:String, interval:StockHistoryInterval){
        self.companySymbol = companySymbol
        self.interval = interval
    }
    private var interval:StockHistoryInterval
    private var companySymbol:String
    var json:JSON = JSON()


    
}

