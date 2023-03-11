//
//  String.swift
//  Crypto App
//
//  Created by VinhHoang on 10/03/2023.
//

import Foundation

extension String {
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
