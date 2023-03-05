//
//  UIApplication.swift
//  Crypto App
//
//  Created by VinhHoang on 04/03/2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
