//
//  MarketDataModel.swift
//  Crypto App
//
//  Created by VinhHoang on 05/03/2023.
//

import Foundation
import Combine

class MarketDataService {
    
    @Published var marketData: MarketDataModel? = nil
    private var dataSubscription: AnyCancellable?
    
    init() {
        getData()
    }
    
    func getData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        dataSubscription = NetworkingManager.dowload(url: url)
            .decode(type: GlobalData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] globalData in
                self?.marketData = globalData.data
                self?.dataSubscription?.cancel()
            })
    }
    
}
