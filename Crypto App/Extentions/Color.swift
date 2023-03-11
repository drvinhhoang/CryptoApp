//
//  Color.swift
//  Crypto App
//
//  Created by VinhHoang on 02/03/2023.
//

import Foundation
import SwiftUI

protocol CryptoAppColor {
    var accent: Color { get }
    var background: Color { get }
    var green: Color { get }
    var red: Color { get }
    var secondaryText: Color { get }
}

extension Color {
    static let theme: CryptoAppColor = ColorTheme()
    static let launch = LaunchTheme()
}

struct ColorTheme: CryptoAppColor {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")

}

struct ColorTheme2: CryptoAppColor {
    let accent = Color("AccentColor2")
    let background = Color("BackgroundColor2")
    let green = Color("GreenColor2")
    let red = Color("RedColor2")
    let secondaryText = Color("SecondaryTextColor2")
}

struct LaunchTheme {
    let background = Color("LaunchBackgroundColor")
    let accent = Color("LaunchAccentColor")
}
