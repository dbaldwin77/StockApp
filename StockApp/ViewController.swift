//
//  ViewController.swift
//  StockApp
//
//  Created by Developer on 11/20/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
import SwiftyJSON
    
class ViewController: UIViewController {
        var stocks: stockData?
        @IBOutlet weak var stockName: UILabel!
        @IBOutlet weak var stockGainLoss: UILabel!
        @IBOutlet weak var lastPrice: UILabel!
        @IBOutlet weak var highPrice: UILabel!
        @IBOutlet weak var lowPrice: UILabel!
        @IBOutlet weak var volume: UILabel!
        @IBOutlet weak var MKcap: UILabel!
        @IBOutlet weak var yearHigh: UILabel!
        @IBOutlet weak var yearLow: UILabel!
        @IBOutlet weak var txtfield: UITextField!

        @IBAction func search(_ sender: UIButton)  {
            let Stockq = txtfield.text
            if let Stockq = Stockq {
            var Quote = "(";
            Quote = Quote+"\""+Stockq+"\","
            Quote = Quote.substring(to: Quote.characters.index(before: Quote.endIndex))
            Quote = Quote + ")"
            
           getStockData(urlString:String ("http://query.yahooapis.com/v1/public/yql?q=select * from yahoo.finance.quotes where symbol IN "+Quote+"&format=json&env=http://datatables.org/alltables.env").addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
            } else {
                print("error")
            }
            
    
            
        }
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
      
        }
    
        func getStockData(urlString: String) {
            
            
            Alamofire.request(urlString)
                .validate()
                
                .responseJSON { response in
                    print("REQUEST \(response.request)")  // original URL request
                    print("RESPONSE \(response.response)") // HTTP URL response
                    print("DATA \(response.data)")     // server data
                    print("RESULT \(response.result)")   // result of response serialization
                    if response.result.isSuccess {
                        if let stockJSON = response.result.value {
                            let parsedData = JSON(stockJSON)
                            print("JSON: \(stockJSON)")
                            
                          
                                
                            let stockname = parsedData["query", "results", "quote", "Name"].string
                            let stockgainloss = parsedData["query", "results", "quote", "Change"].string
                            let lastprice = parsedData["query", "results", "quote", "LastTradePriceOnly"].string
                            let highprice = parsedData["query", "results", "quote", "DaysHigh"].string
                            let lowprice = parsedData["query", "results", "quote", "DaysLow"].string
                            let volume = parsedData["query", "results", "quote", "Volume"].string
                            let mkcap = parsedData["query", "results", "quote", "MarketCapitalization"].string
                            let yearhigh = parsedData["query", "results", "quote", "YearHigh"].string
                            let yearlow = parsedData["query", "results", "quote", "YearLow"].string
 
                            self.stocks = stockData(stockName: stockname!, stockGainLoss: stockgainloss!, lastPrice: lastprice!, highPrice: highprice!, lowPrice: lowprice!, volume: volume!, MKcap: mkcap!, yearHigh: yearhigh!, yearLow: yearlow!)
                           
                            self.setLabel()
                            
                        }
                    } else {
                        print(response.result.error ?? "ERROR")
                    }
            }
   
        }
 

  
        func setLabel() {
            
            if let quotename = stocks?.stockName {
                if let quotegainloss = stocks?.stockGainLoss {
                    if let quotelast = stocks?.lastPrice {
                        if let quotehigh = stocks?.highPrice {
                            if let quotelow = stocks?.lowPrice {
                                if let quotevol = stocks?.volume {
                                    if let quotemk = stocks?.MKcap {
                                        if let quoteyearhigh = stocks?.yearHigh {
                                            if let quoteyearlow = stocks?.yearLow {
                                                stockName.text = quotename
                                                stockGainLoss.text = quotegainloss
                                                lastPrice.text = quotelast
                                                highPrice.text = quotehigh
                                                lowPrice.text = quotelow
                                                volume.text = quotevol
                                                MKcap.text = quotemk
                                                yearHigh.text = quoteyearhigh
                                                yearLow.text = quoteyearlow
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
                   }
  
        override func viewDidLoad()  {
            super.viewDidLoad()
             
    }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            
        }
        
}

