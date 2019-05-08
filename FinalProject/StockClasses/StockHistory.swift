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
    public var history:Dictionary<String,Double>?
    
    init(companySymbol:String, interval:StockHistoryInterval){
        self.companySymbol = companySymbol
        self.interval = interval
        self.history = Dictionary<String,Double>()
        getStockData()
        }

    private func getURL()->URL?{
        let baseURL = "https://www.alphavantage.co/query?"
        var urlComponents = URLComponents(string: baseURL)
        var queryItemsArray = [URLQueryItem]()
        switch interval {
        case .day:
            queryItemsArray.append(URLQueryItem(name: "function", value: "TIME_SERIES_DAILY"))
            queryItemsArray.append(URLQueryItem(name: "outputsize", value: "compact"))
        case .month:
            queryItemsArray.append(URLQueryItem(name: "function", value: "TIME_SERIES_MONTHLY"))
        case .week:
            queryItemsArray.append(URLQueryItem(name: "function", value: "TIME_SERIES_WEEKLY"))
        }
        queryItemsArray.append(URLQueryItem(name: "symbol", value: companySymbol))
        queryItemsArray.append(URLQueryItem(name: "apikey", value: GLOBAL.APIKey))
        urlComponents?.queryItems = queryItemsArray
        return urlComponents?.url
    }
    
    
    public func getStockData() -> Void {
        self.history?.removeAll()
        let theURL = getURL()
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: theURL!, completionHandler: {(data, response, error) in
            if let _ = error {print("Error Here")}
                else if let recivedData = data {
                let parsedData = try? JSON(data: recivedData)
                print (parsedData)
                var theKeys:Dictionary<String,JSON>.Keys?
                var dateFormat = DateFormatter()
                dateFormat.dateFormat = "yyyy-mm-dd"
                switch self.interval{
                case .day:
                    theKeys = parsedData!["Time Series (Daily)"].dictionary?.keys
                    var stringKeys = [String]()
                    for key in theKeys!{
                        stringKeys.append(key)
                    }
                    for key in stringKeys{
                        let val = parsedData!["Time Series (Daily)"][key]["4. close"].floatValue
                        self.history?.updateValue(Double(val), forKey: key)
                    }
                    
                    
                case .week:
                    theKeys = parsedData!["Weekly Time Series"].dictionary?.keys
                    var stringKeys = [String]()
                    for key in theKeys!{
                        stringKeys.append(key)
                    }
                    for key in stringKeys{
                        let val = parsedData!["Weekly Time Series"][key]["4. close"].floatValue
                        self.history?.updateValue(Double(val), forKey:key)
                    }
                case .month:
                    theKeys = parsedData!["Monthly Time Series"].dictionary?.keys
                    var stringKeys = [String]()
                    for key in theKeys!{
                        stringKeys.append(key)
                    }
                    for key in stringKeys{
                        let val = parsedData!["Monthly Time Series"][key]["4. close"].floatValue
                        self.history?.updateValue(Double(val), forKey: key)
                    }
                }
            }
            })
        task.resume()
    }
        }
        

    


