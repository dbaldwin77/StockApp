//
//  Stocks.swift
//  StockCocoaPod
//
//  Created by Developer on 11/20/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import Foundation



class stockData {
    
    var stockName: String
    var stockGainLoss: String
    var lastPrice: String
    var highPrice: String
    var lowPrice: String
    var volume: String
    var MKcap: String
    var yearHigh: String
    var yearLow: String

    
    init(stockName: String, stockGainLoss: String, lastPrice: String, highPrice: String, lowPrice: String, volume: String, MKcap: String, yearHigh: String, yearLow: String) {
    
        self.stockName = stockName
        self.stockGainLoss = stockGainLoss
        self.lastPrice = lastPrice
        self.highPrice = highPrice
        self.lowPrice = lowPrice
        self.volume = volume
        self.MKcap = MKcap
        self.yearHigh = yearHigh
        self.yearLow = yearLow
    }
    
}
