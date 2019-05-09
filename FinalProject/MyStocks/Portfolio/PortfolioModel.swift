//
//  PortfolioModel.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/4/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import Foundation
import Charts

class PortfolioModel {
    var mainModel:MainModel?
    
    init(mainModel:MainModel){
        self.mainModel = mainModel
    }
    
    func getChartDataFor(date:Date, interval:StockHistoryInterval) -> LineChartData {
        
        var lineDataEntry:[ChartDataEntry] = []
        var dateArray:[Date] = []
        
    
        
        switch interval{
        case.day:
            dateArray = (mainModel?.getValidDatesFor(endDate: date, interval: .day))!
            
            for i in 0..<7{
                var doubleValue = 0.0
                
                for stock in (mainModel?.userData)!{
                    doubleValue += stock.valueOfSharesForDate(date: dateArray[i])
                    }
                
                let dataEntry = ChartDataEntry(x: Double(i), y: doubleValue)
                lineDataEntry.append(dataEntry)
            }
            
        case .week:
            dateArray = (mainModel?.getValidDatesFor(endDate: date, interval: .week))!
            
            for i in 0..<7{
                
                var doubleValue = 0.0
                
                for stock in (mainModel?.userData)!{
                    doubleValue += stock.valueOfSharesForWeek(date: dateArray[i])
                }
                
                let dataEntry = ChartDataEntry(x: Double(i), y: doubleValue)
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
    
    
    public func checkValidData(interval:StockHistoryInterval)->Bool{
        for stock in (mainModel?.userData)! {
            if (stock.stockValueHistory![interval]?.isFirstNil())! {return false}
            if (stock.stockValueHistory![interval]?.isHistoryNil())! {return false}
        }
        return true
    }
    
    
    
    public func reloadDataFor(interval:StockHistoryInterval){
        for stock in (mainModel?.userData)! {
         stock.stockValueHistory![interval]?.getStockData()
        }
        
        
    }
    
    public func getSharesForDate(date:Date) -> String {
        var val = 0.0
        for stock in (mainModel?.userData)!{
            val += stock.amountOfSharesForDate(date: date)}
        
        return String(val)
    }
    
    
}
