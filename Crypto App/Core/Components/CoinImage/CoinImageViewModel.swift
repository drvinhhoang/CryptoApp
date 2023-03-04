//
//  CoinImageViewModel.swift
//  Crypto App
//
//  Created by VinhHoang on 04/03/2023.
//

import SwiftUI
import Combine

class CoinImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading = true
    private let coin: Coin
    private let dataService: CoinImageService
    private var cancellables = Set<AnyCancellable>()


    init(coin: Coin) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        addSubscriber()
        isLoading = true
    }
    
    private func addSubscriber() {
        dataService.$image
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                
                self?.image = returnedImage
            }
            .store(in: &cancellables)

    }
}
