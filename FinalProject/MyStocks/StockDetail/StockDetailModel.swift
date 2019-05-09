//
//  StockDetailModel.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/4/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import Foundation
import Charts

class StockDetailModel {
    var mainModel:MainModel?
    
    init(mainModel:MainModel){
        self.mainModel = mainModel
    }
    
    func getChartDataFor(date:Date, symbol:String, interval:StockHistoryInterval) -> LineChartData {
        var lineDataEntry:[ChartDataEntry] = []
        var dateArray:[Date] = []
        
        switch interval{
        case.day:
            dateArray = (mainModel?.getValidDatesFor(endDate: date, interval: .day))!
        
        for i in 0..<7{
            let dataEntry = ChartDataEntry(x: Double(i), y: (mainModel?.getStockWith(symbol: symbol)!.valueOfSharesForDate(date: dateArray[i]))!)
            lineDataEntry.append(dataEntry)
        }
            
        case .week:
            dateArray = (mainModel?.getValidDatesFor(endDate: date, interval: .week))!
            
            for i in 0..<7{
                let dataEntry = ChartDataEntry(x: Double(i), y: (mainModel?.getStockWith(symbol: symbol)!.valueOfSharesForWeek(date: dateArray[i]))!)
                lineDataEntry.append(dataEntry)
            }
        }
        let chartDataSet = LineChartDataSet(entries: lineDataEntry, label: "Value")
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        chartDataSet.colors = [UIColor.blue]
        chartDataSet.setCircleColor(UIColor.blue)
        chartDataSet.circleHoleColor = UIColor.blue
        chartDataSet.circleRadius = 2.0
        
    
        
        return LineChartData(dataSet: chartDataSet)
    }
    
    
    func getLablesFor(date: Date, interval:StockHistoryInterval) ->IndexAxisValueFormatter {
        
        let format = DateFormatter()
        format.dateFormat = "MM-dd"
        let dateArray = mainModel?.getValidDatesFor(endDate: date, interval: interval)
        var stringArray:[String] = []
        
        for date in dateArray! {
            let cal = Calendar(identifier: .gregorian)
            let newDate = cal.date(from: cal.dateComponents([.month, .day], from: date))
            stringArray.append(format.string(from: newDate!))
        }
        return IndexAxisValueFormatter(values:  stringArray)
    }
    
    
    func checkValidData(symbol:String, interval: StockHistoryInterval) -> Bool {
        if (mainModel?.getStockWith(symbol: symbol)?.stockValueHistory![interval]?.isFirstNil())! {return false}
        if (mainModel?.getStockWith(symbol: symbol)?.stockValueHistory![interval]?.isHistoryNil())! {return false}
        return true
    }
    
    
    func reloadDataFor(symbol:String, interval:StockHistoryInterval){
        mainModel?.getStockWith(symbol: symbol)?.stockValueHistory![interval]?.getStockData()
        
    }
    
    func getSharesForDate(date:Date, symbol:String) -> String {
        if let x = mainModel?.getStockWith(symbol: symbol)?.amountOfSharesForDate(date: date){return String(x)}
        return String(0)
        
    }
}
