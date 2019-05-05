//
//  StockHistory.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/2/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import Foundation

class StockHistory{
    private var interval:StockHistoryInterval
    private var companySymbol:String
    
    init(companySymbol:String, interval:StockHistoryInterval){
        self.companySymbol = companySymbol
        self.interval = interval
        }
    
   


    private func getURL()->URL?{
       let urlText = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=MSFT&outputsize=full&apikey=" + GLOBAL.APIKey
        let testURL = URL(string: urlText)
        return testURL
    }
    
    
    func getStockData() -> Void {
        let theURL = getURL()
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: theURL!, completionHandler: {(data, response, error) in
            if let _ = error {print("Error Here")}
                else if let recivedData = data {
                    let parsedData = try? JSON(data: recivedData)
                print(parsedData!["Time Series (Daily)"].count)
            
            }
                    
                    
            
                
            })
        task.resume()
        
    }
        }
        

    


