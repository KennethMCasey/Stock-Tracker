//
//  MyStocksModel.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/4/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import Foundation

class MyStocksModel{
    var mainModel:MainModel
    init (mainModel:MainModel){self.mainModel = mainModel}
    public func numOfRows() -> Int {return mainModel.userData.count + 1}
    public func getNameFor(row:Int) -> String {return (mainModel.getStockAt(index: row-1)?.symbol!)!}
}
