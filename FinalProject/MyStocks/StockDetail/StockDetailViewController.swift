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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockDetailModel = StockDetailModel(mainModel:mainModel!)
        
        lineGraph.delegate = self
        lineGraph.xAxis.drawLabelsEnabled = true
        lineGraph.xAxis.axisRange = 7
        lineGraph.xAxis.labelPosition = .bottom
        lineGraph.rightAxis.enabled = false
        
        dialDate.datePickerMode = .date
        dialDate.minimumDate = Date(timeIntervalSinceNow: TimeInterval(-630700000))
        dialDate.maximumDate = Date()
    }
    
    @IBAction func DayButtonPressed(_ sender: UIButton) {
        lineGraph.clearValues()
        lineGraph.data = stockDetailModel!.getChartDataFor(date: dialDate.date, symbol:stockSymbol!, interval: .day)
        lineGraph.xAxis.valueFormatter = stockDetailModel?.getLablesFor(date: dialDate.date, interval: .day)
        lineGraph.xAxis.wordWrapEnabled = true
    }
    

    @IBAction func WeekButtonPressed(_ sender: UIButton) {
        lineGraph.clearValues()
        lineGraph.data = stockDetailModel!.getChartDataFor(date: dialDate.date, symbol:stockSymbol!, interval: .week)
        lineGraph.xAxis.valueFormatter = stockDetailModel?.getLablesFor(date: dialDate.date, interval: .week)
        lineGraph.xAxis.wordWrapEnabled = true
      
    }
    
    
    @IBAction func MonthButtonPressed(_ sender: Any) {
        //lineGraph.data = stockDetailModel.getChartDataFor()
    }
    
    
    
}
