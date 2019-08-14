//
//  ProductIds.swift
//  CoinbaseSocketSwift
//
//  Created by Hani Shabsigh on 10/29/17.
//  Copyright © 2017 Hani Shabsigh. All rights reserved.
//

import Foundation

public enum ProductIds: String, CaseIterable {
    case BTCUSD = "BTC-USD"
    case BTCEUR = "BTC-EUR"
    case BTCGBP = "BTC-GBP"
    case ETHUSD = "ETH-USD"
    case ETHBTC = "ETH-BTC"
    case ETHEUR = "ETH-EUR"
    case ETHGBP = "ETH-GBP"
    case LTCUSD = "LTC-USD"
    case LTCBTC = "LTC-BTC"
    case LTCEUR = "LTC-EUR"
    case LTCGBP = "LTC-GBP"
    case BCHUSD = "BCH-USD"
    case BCHBTC = "BCH-BTC"
    case BCHEUR = "BCH-EUR"
    case BCHGBP = "BCH-GBP"
    case ETCUSD = "ETC-USD"
    case ETCBTC = "ETC-BTC"
    case ETCEUR = "ETC-EUR"
    case ETCGBP = "ETC-GBP"
    case ZRXUSD = "ZRX-USD"
    case ZRXBTC = "ZRX-BTC"
    case ZRXEUR = "ZRX-EUR"
    case BTCUSDC = "BTC-USDC"
    case ETHUSDC = "ETH-USDC"
    case BATUSDC = "BAT-USDC"
    case BATETH = "BAT-ETH"
    case ZECUSDC = "ZEC-USDC"
    case ZECBTC = "ZEC-BTC"
    case REPUSD = "REP-USD"
    case EOSUSD = "EOS-USD"
    case ETHDAI = "ETH-DAI"
    case XRPUSD = "XRP-USD"
    case XRPEUR = "XRP-EUR"
    case XRPBTC = "XRP-BTC"
    case DAIUSDC = "DAI-USDC"
    case LOOMUSDC = "LOOM-USDC"
    case GNTUSDC = "GNT-USDC"
    case MANAUSDC = "MANA-USDC"
    case CVCUSDC = "CVC-USDC"
    case DNTUSDC = "DNT-USDC"
    case EOSEUR = "EOS-EUR"
    case REPBTC = "REP-BTC"
    case XLMEUR = "XLM-EUR"
    case XLMBTC = "XLM-BTC"
    case XLMUSD = "XLM-USD"
    case EOSBTC = "EOS-BTC"
}

public struct DefaultProductIds {
    public static func allCases() -> [String] {
        return ProductIds.allCases.map { $0.rawValue }
    }
}
