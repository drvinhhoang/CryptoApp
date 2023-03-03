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
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    //.navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
