//
//  NavigationLazyView.swift
//  Crypto App
//
//  Created by VinhHoang on 07/03/2023.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}
