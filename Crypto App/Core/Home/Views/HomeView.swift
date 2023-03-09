//
//  HomeView.swift
//  Crypto App
//
//  Created by VinhHoang on 02/03/2023.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    
    @State private var showPortfolio: Bool = false
    @State private var showPortfolioView: Bool = false
    
    @State private var seletedCoin: Coin? = nil
    @State private var showDetailView: Bool = false
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                }
            VStack {
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                columnTitles
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationStack {
                HomeView()
            }
            .environmentObject(dev.homeVM)
            NavigationStack {
                HomeView()
            }
            .preferredColorScheme(.dark)
            .environmentObject(dev.homeVM)
        }
    }
       
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List {
            ForEach(vm.allCoins) { coin in
                NavigationLink(destination: NavigationLazyView(
                    DetailView(coin: coin)
                )) {
                    CoinRowView(coin: coin, showHoldingColumn: false)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                NavigationLink(destination: NavigationLazyView(
                    DetailView(coin: coin)
                )) {
                    CoinRowView(coin: coin, showHoldingColumn: true)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                }
                
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private func segue(coin: Coin) {
        self.seletedCoin = coin
        showDetailView.toggle()
        LogMess.log("\(showDetailView)")
    }
    
    private var columnTitles: some View {
        HStack {
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
            }
           
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((vm.sortOption == .holdings || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    vm.sortOption = vm.sortOption == .holdings ? .holdingReversed : .holdings
                }
            }
            HStack(spacing: 4) {
                
                Text("Price")
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
                
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0 : 180))
                
                Button(action: {
                    withAnimation(.linear(duration: 2.0)) {
                        vm.reloadData()
                    }
                }, label: {
                    Image(systemName: "goforward")
                })
                .rotationEffect(Angle(degrees: vm.isLoading ? 360 : 0), anchor: .center)
             
            }
            .onTapGesture {
                vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
            }
        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .padding(.horizontal)
    }
}
