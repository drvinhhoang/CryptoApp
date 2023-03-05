//
//  HomeViewModel.swift
//  Crypto App
//
//  Created by VinhHoang on 03/03/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statstistics: [StatisticModel] = []
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .map(filterCoin)
            .sink { [weak self] coins in
                self?.allCoins = coins
            }
            .store(in: &cancellables)
        
        // updates marketData
        marketDataService.$marketData
            .map(mapMarketData)
            .sink { [weak self] stats in
                self?.statstistics = stats
            }
            .store(in: &cancellables)
    }
    
    private func filterCoin(searchText: String, coins: [Coin]) -> [Coin] {
            guard !searchText.isEmpty else {
                return coins
            }
            let lowercaseText = searchText.lowercased()
            
            let matchedCoins = coins.filter({ coin in
                coin.name == lowercaseText || coin.id == lowercaseText || coin.symbol == lowercaseText
            })
            if !matchedCoins.isEmpty {
                return matchedCoins
            } else {
                return coins.filter({ $0.name.lowercased().contains(lowercaseText) ||
                    $0.symbol.lowercased().contains(lowercaseText) ||
                    $0.id.lowercased().contains(lowercaseText)
                })
            }
    }
    
    private func mapMarketData(marketData: MarketDataModel?) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let marketData = marketData else {
            return stats
        }
        let marketCap = StatisticModel(title: "Market cap", value: marketData.marketCap, percentageChange: marketData.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: marketData.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: marketData.btcDominance)
        let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
}
