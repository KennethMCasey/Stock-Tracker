//
//  AddStockModel.swift
//  FinalProject
//
//  Created by Kenny Casey on 5/5/19.
//  Copyright © 2019 Kenny Casey. All rights reserved.
//

import Foundation


class AddStockModel{

    public var searchResults : [Stock]?
    public var mainModel : MainModel?
    
    
    init (mainModel: MainModel ) {
        self.mainModel = mainModel
        searchResults = [Stock]()}
    
    
    public func loadResults(searchTerm:String, completionHandler: (()->())?){
        searchResults?.removeAll()
        let baseURL = "https://www.alphavantage.co/query?"
        var urlComponents = URLComponents(string: baseURL)
        var queryItemArrays=Array<URLQueryItem>()
        queryItemArrays.append(URLQueryItem(name: "function", value: "SYMBOL_SEARCH"))
        queryItemArrays.append(URLQueryItem(name: "keywords", value: searchTerm))
        queryItemArrays.append(URLQueryItem(name: "apikey", value: GLOBAL.APIKey))
        urlComponents?.queryItems = queryItemArrays
        
        let session = URLSession(configuration: .ephemeral)
        let task = session.dataTask(with: (urlComponents?.url)!){
            (data, response, error) in
            if let _ = error {print ("error here")}
            else if let _ = data {
                let jsonData = try? JSON(data: data!)
                for (_, x) in (jsonData?["bestMatches"])!{
                    if x["8. currency"] == "USD" {
                        let symbol = x["1. symbol"].string
                        let companyName = x["2. name"].string
                        self.searchResults?.append(Stock(symbol: symbol!, companyName: companyName!))
                    }
                }
            }
            DispatchQueue.main.async {
                completionHandler?()
            }
        }
        task.resume()
        
    }
    
    func numResults()->Int {
        return searchResults?.count ?? 0
    }
}
