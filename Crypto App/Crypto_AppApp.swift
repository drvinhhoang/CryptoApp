//
//  Crypto_AppApp.swift
//  Crypto App
//
//  Created by VinhHoang on 01/03/2023.
//

import SwiftUI

@main
struct Crypto_AppApp: App {
    
    @StateObject var vm = HomeViewModel()
    
    init() {
        UITableView.appearance().backgroundColor = UIColor.clear
        UINavigationBar.appearance().tintColor = UIColor(Color.theme.accent)
    }
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationStack {
                    HomeView()
                }
                ZStack {
                    if vm.showLaunchView {
                        LaunchView()
                            .transition(AnyTransition.move(edge: .leading))
                    }
                }
                .zIndex(2.0)
            }
            .environmentObject(vm)
        }
    }
}
