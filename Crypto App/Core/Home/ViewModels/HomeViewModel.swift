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
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .holdings
    @Published var showLaunchView: Bool = true
    
    private let coinDataService = CoinDataService()
    private let marketDataService = MarketDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellables = Set<AnyCancellable>()
    
    enum SortOption {
        case rank, rankReversed,holdings, holdingReversed, price, priceReversed
    }
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .dropFirst()
            .map(filterAndSortCoin)
            .sink { [weak self] coins in
                self?.showLaunchView = false
                self?.allCoins = coins
            }
            .store(in: &cancellables)
        
        // updates portfolioCoins
        $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map(mapAllCoinsToPortfolio)
            .sink { [weak self] returnedCoins in
                guard let self = self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        // updates marketData
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapMarketData)
            .sink { [weak self] stats in
                self?.statstistics = stats
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    func mapAllCoinsToPortfolio(coins: [Coin], portfolioEntities: [PortfolioEntity]) -> [Coin] {
        coins
            .compactMap { coin -> Coin? in
                guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                    return nil
                }
                return coin.updateHoldings(amount: entity.amount)
            }
    }
    
    func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getData()
        HapticManager.notification(type: .success)
    }
    
    private func filterAndSortCoin(searchText: String, coins: [Coin], sortOption: SortOption) -> [Coin] {
        var filteredCoins = filterCoin(searchText: searchText, coins: coins)
        sortCoins(sort: sortOption, coins: &filteredCoins)
        return filteredCoins
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
    
    private func sortCoins(sort: SortOption, coins: inout [Coin]) {
        switch sort {
        case .rank, .holdings:
            coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed, .holdingReversed:
            coins.sort(by: { $0.rank > $1.rank })
        case .price:
            coins.sort(by: { $0.currentPrice > $1.currentPrice })
        case .priceReversed:
            coins.sort(by: { $0.currentPrice < $1.currentPrice })
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [Coin]) -> [Coin] {
        switch sortOption {
        case .holdings:
            return coins.sorted(by: { $0.currentHoldingsValue > $1.currentHoldingsValue })
        case .holdingReversed:
            return coins.sorted(by: { $0.currentHoldingsValue < $1.currentHoldingsValue })
        default:
            return coins
        }
    }
    
    private func mapMarketData(marketData: MarketDataModel?, portfolioCoins: [Coin]) -> [StatisticModel] {
        var stats: [StatisticModel] = []
        guard let marketData = marketData else {
            return stats
        }
        let marketCap = StatisticModel(title: "Market cap", value: marketData.marketCap, percentageChange: marketData.marketCapChangePercentage24HUsd)
        let volume = StatisticModel(title: "24h Volume", value: marketData.volume)
        let btcDominance = StatisticModel(title: "BTC Dominance", value: marketData.btcDominance)
        
        let portfolioValue =
        portfolioCoins
            .map(\.currentHoldingsValue)
            .reduce(0, +)
        
        let previousValue =
        portfolioCoins
            .compactMap { coin -> Double? in
                guard let priceChangePercentage24H = coin.priceChangePercentage24H else { return nil }
                let currentValue = coin.currentHoldingsValue
                let percentChange = priceChangePercentage24H / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100

        let portfolio = StatisticModel(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange)
        
        stats.append(contentsOf: [
            marketCap,
            volume,
            btcDominance,
            portfolio
        ])
        return stats
    }
}
