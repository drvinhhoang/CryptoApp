//
//  DetailView.swift
//  Crypto App
//
//  Created by VinhHoang on 07/03/2023.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var vm: DetailViewModel
    
    private let spacing: CGFloat = 30
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    init(coin: Coin) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        LogMess.log("init detailView for: \(coin.name)")
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                overViewTitle
                Divider()
                overviewGrid
                addtionalTitle
                Divider()
                addtionalGrid
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
               navigationBarTrailingItems
            }
        }
        
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(coin: dev.coin)
        }
    }
}

extension DetailView {
    
    private var navigationBarTrailingItems: some View {
        HStack {
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        }
    }
    private var overViewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var addtionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: spacing) {
            ForEach(vm.overViewStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var addtionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing) {
                ForEach(vm.additionalStatistics) { stat in
                    StatisticView(stat: stat)
                }
            }
    }
    
}
