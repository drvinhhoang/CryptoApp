//
//  CoinImageService.swift
//  Crypto App
//
//  Created by VinhHoang on 04/03/2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image: UIImage? = nil
    var imageSubscription: AnyCancellable?
    private let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
        getCoinImage()
    }
    
    func getCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        imageSubscription = NetworkingManager.dowload(url: url)
            .tryMap({ data in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                LogMess.log("vinhht download image: \(returnedImage)")
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}
