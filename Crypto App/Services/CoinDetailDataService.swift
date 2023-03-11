//
//  CoinDetailDataService.swift
//  Crypto App
//
//  Created by VinhHoang on 09/03/2023.
//

import Foundation
import Combine

class CoinDetailDataService {
    
    @Published var coinDetail: CoinDetail? = nil
    
    private var coinDetailSubscription: AnyCancellable?
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        getCoinDetail()
    }
    
    func getCoinDetail() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
        
        coinDetailSubscription = NetworkingManager.dowload(url: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedCoinDetail in
                self?.coinDetail = returnedCoinDetail
                self?.coinDetailSubscription?.cancel()
            })
    }
    
}
