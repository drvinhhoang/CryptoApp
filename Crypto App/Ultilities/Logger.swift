//
//  Logger.swift
//  Crypto App
//
//  Created by VinhHoang on 04/03/2023.
//

import Foundation
import OSLog

struct LogMess {
    private static let logger = Logger()
    static func log(_ mess: String, file: String = #file, line: Int = #line, function: String = #function) {
        logger.log(level: .default, "[\(Date().formatted())][file: \(file), line: \(line), function: \(function)] : \(mess)")
    }
}
