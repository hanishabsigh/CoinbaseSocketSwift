//
//  ViewController.swift
//  CoinbaseSocketSwift
//
//  Created by Hani Shabsigh on 11/04/2018.
//  Copyright (c) 2018 Hani Shabsigh. All rights reserved.
//

import UIKit
import CoinbaseSocketSwift

class ViewController: UIViewController {
    
    var socketClient: CoinbaseSocketClient = CoinbaseSocketClient()
    let priceFormatter: NumberFormatter = NumberFormatter()
    let timeFormatter: DateFormatter = DateFormatter()
    var selectedProductId: ProductId = .BTCUSD
    
    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productIdLabel: UILabel!
    @IBOutlet weak var productIdPicker: UIPickerView!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socketClient.delegate = self
        socketClient.webSocket = ExampleWebSocketClient(url: URL(string: CoinbaseSocketClient.baseProAPIURLString)!)
        socketClient.logger = CoinbaseSocketClientDefaultLogger()
        
        priceFormatter.numberStyle = .decimal
        priceFormatter.maximumFractionDigits = 2
        priceFormatter.minimumFractionDigits = 2
        
        timeFormatter.dateStyle = .short
        timeFormatter.timeStyle = .medium
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !socketClient.isConnected {
            socketClient.connect()
        }
    }
    
    func subscribe() {
        socketClient.subscribe(channels:[.ticker], productIds:[selectedProductId])
    }
    
    func unsubscribe() {
        socketClient.unsubscribe(channels:[.ticker], productIds:[selectedProductId])
    }
    
    func updateUI(ticker: TickerMessage?) {
        if let ticker = ticker {
            productIdLabel.text = ticker.productId.rawValue
            tickerLabel.text =  ticker.type.rawValue
            
            let formattedPrice = priceFormatter.string(from: ticker.price as NSNumber) ?? "0.0000"
            priceLabel.text = "Price = " + formattedPrice
            
            if let time = ticker.time {
                timeLabel.text = timeFormatter.string(from: time)
            }
        } else {
            productIdLabel.text = selectedProductId.rawValue
            tickerLabel.text = "waiting for data..."
            priceLabel.text = "..."
            timeLabel.text = nil
        }
    }
}

extension ViewController: CoinbaseSocketClientDelegate {
    func coinbaseSocketDidConnect(socket: CoinbaseSocketClient) {
        subscribe()
    }
    
    func coinbaseSocketDidDisconnect(socket: CoinbaseSocketClient, error: Error?) {
        
    }
    
    func coinbaseSocketClientOnErrorMessage(socket: CoinbaseSocketClient, error: ErrorMessage) {
        print(error.message)
    }
    
    func coinbaseSocketClientOnTicker(socket: CoinbaseSocketClient, ticker: TickerMessage) {
        updateUI(ticker: ticker)
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ProductId.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        unsubscribe()
        selectedProductId = ProductId.allCases[row]
        updateUI(ticker: nil)
        subscribe()
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ProductId.allCases.count
    }
}
