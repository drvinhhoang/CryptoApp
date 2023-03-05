//
//  HomeViewModel.swift
//  Crypto App
//
//  Created by VinhHoang on 03/03/2023.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var statstistics: [StatisticModel] = [
        StatisticModel(title: "title", value: "$12.5Bn", percentageChange: 1),
        StatisticModel(title: "title", value: "$1.23Tr", percentageChange: 2),
        StatisticModel(title: "title", value: "$50.4k", percentageChange: -3),
        StatisticModel(title: "title", value: "$1.23Tr", percentageChange: 4),
        StatisticModel(title: "title", value: "$12.5Bn", percentageChange: -5),
    ]
    
    private let coinDataService = CoinDataService()
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .map(filterCoin)
            .sink { [weak self] coins in
                self?.allCoins = coins
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
}
