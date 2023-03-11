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
    private let fileManager = LocalFileManager.instance
    private let coin: Coin
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    func getCoinImage() {
        if let savedImage = fileManager.getImage(imageName: self.imageName, folderName: folderName) {
            image = savedImage
           // LogMess.log("Retrieved image from FileManager")
        } else {
           // LogMess.log("download image")
            downloadImage()
        }
    }
    
    func downloadImage() {
        guard let url = URL(string: coin.image) else { return }
        imageSubscription = NetworkingManager.dowload(url: url)
            .tryMap({ data in
                return UIImage(data: data)
            })
            .receive(on: DispatchQueue.main)

            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] returnedImage in
                guard let self = self, let downloadedImage = returnedImage else { return }
                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
            })
    }
}
