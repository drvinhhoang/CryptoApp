//
//  MarketDataModel.swift
//  Crypto App
//
//  Created by VinhHoang on 05/03/2023.
//

import Foundation
// JSON data
/*
 URL: https://api.coingecko.com/api/v3/global
 Response:
 {
   "data": {
     "active_cryptocurrencies": 12294,
     "upcoming_icos": 0,
     "ongoing_icos": 49,
     "ended_icos": 3376,
     "markets": 666,
     "total_market_cap": {
       "btc": 47960443.10324156,
       "eth": 686247453.3174754,
       "ltc": 11831135448.830267,
       "bch": 8544060176.4338,
       "bnb": 3703741400.806813,
       "eos": 875364518031.4004,
       "xrp": 2862570809981.2563,
       "xlm": 12730622831152.414,
       "link": 154869743957.77594,
       "dot": 179179171306.07108,
       "yfi": 104385080.42566875,
       "usd": 1082261259122.3822,
       "aed": 3974999499486.5356,
       "ars": 214258400026109.9,
       "aud": 1598982568245.3303,
       "bdt": 115832005874477.23,
       "bhd": 407417250996.6214,
       "bmd": 1082261259122.3822,
       "brl": 5623321276273.982,
       "cad": 1473877495735.816,
       "chf": 1013108011448.2393,
       "clp": 867518980087319.4,
       "cny": 7476044325765.609,
       "czk": 23901739907717.86,
       "dkk": 7572473803953.3955,
       "eur": 1017019303638.7115,
       "gbp": 899261702817.3812,
       "hkd": 8494289831410.88,
       "huf": 385891074552676.94,
       "idr": 16534516951557014,
       "ils": 3972412895077.232,
       "inr": 88434543701352.72,
       "jpy": 147019799490245.2,
       "krw": 1402374192413516.5,
       "kwd": 332232561325.38947,
       "lkr": 374693733329526.94,
       "mmk": 2273356799226345.5,
       "mxn": 19433732525556.992,
       "myr": 4844201395831.777,
       "ngn": 496757917937173,
       "nok": 11235278809327.182,
       "nzd": 1738851848851.7898,
       "php": 59226753899039.82,
       "pkr": 301842665169232.7,
       "pln": 4790395695073.262,
       "rub": 81602482703908.92,
       "sar": 4061595551873.95,
       "sek": 11315907273131.797,
       "sgd": 1455826460194.917,
       "thb": 37272749839013.41,
       "try": 20372811702358.727,
       "twd": 33023037799601.3,
       "uah": 39979862957257.88,
       "vef": 108366819875.92406,
       "vnd": 25676648372678536,
       "zar": 19635033119753.76,
       "xdr": 814178651670.2161,
       "xag": 50913173559.10972,
       "xau": 583317173.4417819,
       "bits": 47960443103241.56,
       "sats": 4796044310324156
     },
     "total_volume": {
       "btc": 4232486.3121768,
       "eth": 60561011.63786142,
       "ltc": 1044092080.9862021,
       "bch": 754009250.275813,
       "bnb": 326853418.535198,
       "eos": 77250502726.95941,
       "xrp": 252620513634.57144,
       "xlm": 1123471415023.1914,
       "link": 13667181307.324272,
       "dot": 15812476718.524536,
       "yfi": 9211933.741856033,
       "usd": 95509041807.1036,
       "aed": 350791816836.8482,
       "ars": 18908201982773.582,
       "aud": 141109451781.73828,
       "bdt": 10222119472923.969,
       "bhd": 35954378788.2842,
       "bmd": 95509041807.1036,
       "brl": 496255430325.5293,
       "cad": 130068988585.00401,
       "chf": 89406300562.7551,
       "clp": 76558137731738.12,
       "cny": 659757358995.1118,
       "czk": 2109317188309.8872,
       "dkk": 668267214620.123,
       "eur": 89751470239.84631,
       "gbp": 79359417927.94069,
       "hkd": 749617040979.3232,
       "huf": 34054703946740.89,
       "idr": 1459163263468480.5,
       "ils": 350563550226.92914,
       "inr": 7804306455923.431,
       "jpy": 12974427438502.607,
       "krw": 123758856046495.36,
       "kwd": 29319365653.944714,
       "lkr": 33066543904980.305,
       "mmk": 200622657190780.62,
       "mxn": 1715017660113.4387,
       "myr": 427498471128.5952,
       "ngn": 43838650189460.516,
       "nok": 991508015712.0841,
       "nzd": 153452849326.8048,
       "php": 5226732885947.986,
       "pkr": 26637471760001.22,
       "pln": 422750143606.1144,
       "rub": 7201380319620.001,
       "sar": 358433877308.00146,
       "sek": 998623439326.7133,
       "sgd": 128475993276.70361,
       "thb": 3289302460596.9873,
       "try": 1797890951198.5027,
       "twd": 2914267392660.1567,
       "uah": 3528203906812.141,
       "vef": 9563320356.145277,
       "vnd": 2265952016873534.5,
       "zar": 1732782341889.5605,
       "xdr": 71850879097.23343,
       "xag": 4493063371.715369,
       "xau": 51477463.35319273,
       "bits": 4232486312176.8003,
       "sats": 423248631217680.06
     },
     "market_cap_percentage": {
       "btc": 40.25954463855852,
       "eth": 17.483041369929957,
       "usdt": 6.63906062354468,
       "bnb": 4.2682452630781835,
       "usdc": 4.068934543749932,
       "xrp": 1.7807762335820825,
       "okb": 1.1415437602349219,
       "ada": 1.110374499800822,
       "doge": 0.9753892492912462,
       "matic": 0.9657422355853611
     },
     "market_cap_change_percentage_24h_usd": 0.48126012492142184,
     "updated_at": 1677990822
   }
 }
 */

struct GlobalData: Codable {
    let data: MarketDataModel?
}

struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double?
    
    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
    
    var marketCap: String {
        if let item = totalMarketCap["usd"] {
            return item.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume["usd"]{
            return item.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage["btc"] {
            return item.asPercentString()
        }
        return ""
    }
}