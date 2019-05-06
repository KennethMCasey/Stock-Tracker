//
//  ModifyStockModel.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/5/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import Foundation

class ModifyStockModel {
    var mainModel : MainModel?
    
    init (mainModel:MainModel) {
        self.mainModel = mainModel
    }
    
    public func numOfRows() -> Int {return (mainModel?.userData.count)!}
    
    public func getNameFor(row:Int) -> String {
        return (mainModel?.getStockAt(index: row)?.symbol)!
    }
    
}
