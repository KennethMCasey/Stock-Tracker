//
//  StockDetailViewController.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/4/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import UIKit
import Charts


class StockDetailViewController: UIViewController , ChartViewDelegate{
    var mainModel:MainModel?
    var stockDetailModel:StockDetailModel?
    var stockSymbol:String?
    
    @IBOutlet weak var lineGraph: LineChartView!
    
    @IBOutlet weak var dialDate: UIDatePicker!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblSharesAtDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockDetailModel = StockDetailModel(mainModel:mainModel!)
        
        lblName.text = stockSymbol
        
        lblSharesAtDate.text = "Select Day"
        
        lineGraph.delegate = self
        lineGraph.xAxis.drawLabelsEnabled = true
        lineGraph.xAxis.axisRange = 7
        lineGraph.xAxis.labelPosition = .bottom
        lineGraph.rightAxis.enabled = false
        lineGraph.noDataText = "Please Select Graph To Load..."
        
        dialDate.datePickerMode = .date
        dialDate.minimumDate = Date(timeIntervalSinceNow: TimeInterval(-11830000))
        dialDate.maximumDate = Date()
    }
    
    @IBAction func DayButtonPressed(_ sender: UIButton) {
        lineGraph.clearValues()
        lineGraph.noDataText = "API CALL LIMT REACHED, PLEASE WAIT ONE MINUTE THEN TRY AGAIN"
        if stockDetailModel!.checkValidData(symbol: stockSymbol!, interval: .day){
            lblSharesAtDate.text = stockDetailModel!.getSharesForDate(date: dialDate.date, symbol: stockSymbol!)
        lineGraph.data = stockDetailModel!.getChartDataFor(date: dialDate.date, symbol:stockSymbol!, interval: .day)
        lineGraph.xAxis.valueFormatter = stockDetailModel?.getLablesFor(date: dialDate.date, interval: .day)
            lineGraph.xAxis.wordWrapEnabled = true
             lineGraph.noDataText = "Please Select Graph To Load..."
        }
        else {stockDetailModel!.reloadDataFor(symbol: stockSymbol!, interval: .day)}
        
    }
    

    @IBAction func WeekButtonPressed(_ sender: UIButton) {
        lineGraph.clearValues()
        lineGraph.noDataText = "API CALL LIMT REACHED, PLEASE WAIT ONE MINUTE THEN TRY AGAIN"
        if stockDetailModel!.checkValidData(symbol: stockSymbol!, interval: .week){
            lblSharesAtDate.text = stockDetailModel!.getSharesForDate(date: dialDate.date, symbol: stockSymbol!)
        lineGraph.data = stockDetailModel!.getChartDataFor(date: dialDate.date, symbol:stockSymbol!, interval: .week)
        lineGraph.xAxis.valueFormatter = stockDetailModel?.getLablesFor(date: dialDate.date, interval: .week)
            lineGraph.xAxis.wordWrapEnabled = true
             lineGraph.noDataText = "Please Select Graph To Load..."
        }
        else {stockDetailModel!.reloadDataFor(symbol: stockSymbol!, interval: .week)}
      
    }
    
    
    @IBAction func MonthButtonPressed(_ sender: Any) {
        //lineGraph.data = stockDetailModel.getChartDataFor()
    }
    
    
    
}
