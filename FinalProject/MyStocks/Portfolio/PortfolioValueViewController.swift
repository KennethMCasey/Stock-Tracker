//
//  PortfolioValueViewController.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/4/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import UIKit
import Charts

class PortfolioValueViewController: UIViewController, ChartViewDelegate {
    var mainModel:MainModel?
    var portfolioModel:PortfolioModel?
    
    @IBOutlet weak var lblSharesAtDate: UILabel!
    
    @IBOutlet weak var lineGraph: LineChartView!
    
    @IBOutlet weak var dialDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        portfolioModel = PortfolioModel(mainModel:mainModel!)
        
        lblSharesAtDate.text = "Select Date"
        
        lineGraph.delegate = self
        lineGraph.xAxis.drawLabelsEnabled = true
        lineGraph.xAxis.axisRange = 7
        lineGraph.xAxis.labelPosition = .bottom
        lineGraph.rightAxis.enabled = false
        
        dialDate.datePickerMode = .date
        dialDate.minimumDate = Date(timeIntervalSinceNow: TimeInterval(-11830000))
        dialDate.maximumDate = Date()
    }
    
    @IBAction func DayButtonPressed(_ sender: UIButton) {
        lineGraph.clearValues()
        lineGraph.noDataText = "API CALL LIMT REACHED, PLEASE WAIT ONE MINUTE THEN TRY AGAIN"
        if portfolioModel!.checkValidData(interval: .day){
        lblSharesAtDate.text = portfolioModel!.getSharesForDate(date: dialDate.date)
        lineGraph.data = portfolioModel!.getChartDataFor(date: dialDate.date, interval: .day)
        lineGraph.xAxis.valueFormatter = portfolioModel?.getLablesFor(date: dialDate.date, interval: .day)
            lineGraph.xAxis.wordWrapEnabled = true
            lineGraph.noDataText = "Please Select Graph To Load..."
        }
        else {portfolioModel!.reloadDataFor(interval: .day)}
    }
    
    
    @IBAction func WeekButtonPressed(_ sender: UIButton) {
        lineGraph.clearValues()
        lineGraph.noDataText = "API CALL LIMT REACHED, PLEASE WAIT ONE MINUTE THEN TRY AGAIN"
         if portfolioModel!.checkValidData(interval: .day){
            lblSharesAtDate.text = portfolioModel!.getSharesForDate(date: dialDate.date)
        lineGraph.data = portfolioModel!.getChartDataFor(date: dialDate.date, interval: .week)
        lineGraph.xAxis.valueFormatter = portfolioModel?.getLablesFor(date: dialDate.date, interval: .week)
            lineGraph.xAxis.wordWrapEnabled = true
            lineGraph.noDataText = "Please Select Graph To Load..."
        }
        else {portfolioModel!.reloadDataFor(interval: .week)}
    }
    
    
    
}


