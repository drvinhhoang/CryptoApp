//
//  SettingView.swift
//  Crypto App
//
//  Created by VinhHoang on 11/03/2023.
//

import SwiftUI

struct InfomationView: View {
    
    private let coingeckoURL = URL(string: "https://www.coingecko.com")!
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading) {
                        Image("coingecko")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        Text("The cryptocurrency data that is used in this app comes from a free API from CoinGeko! Prices may be slightly delayed.")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundColor(.theme.accent)
                    }
                    .padding(.vertical)
                    Link("Visit CoinGecko", destination: coingeckoURL)
                        .foregroundColor(.blue)

                    
                } header: {
                    Text("CoinGecko")
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Information")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton()
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        InfomationView()
    }
}
