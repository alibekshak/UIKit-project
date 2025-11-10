//
//  NetworkLoggerPluginConfig.swift
//  UIKit-project
//
//  Created by Alibek Shakirov on 10.11.2025.
//

import Foundation
import Moya

enum NetworkLoggerPluginConfig {
    static let prettyLogging = NetworkLoggerPlugin.Configuration(
        formatter: NetworkLoggerPlugin.Configuration.Formatter(
            requestData: JSONDataToStringFormatter,
            responseData: JSONDataToStringFormatter
        ),
        output: safeOutput,
        logOptions: [.verbose]
    )
    
    nonisolated private static func JSONDataToStringFormatter(_ data: Data) -> String {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? ""
        } catch {
            return String(data: data, encoding: .utf8) ?? ""
        }
    }

    nonisolated private static func safeOutput(target: TargetType, items: [String]) {
        #if DEBUG
        for item in items {
            if item.contains("Request:") {
                print("📡 \(item)")
            } else if item.contains("Response:") {
                let statusCode = extractStatusCode(from: item)
                let emoji = (200...299).contains(statusCode) ? "✅" : "❌"
                print("\(emoji) \(item)")
            } else {
                print("🔍 \(item)")
            }
        }
        #endif
    }
    
    nonisolated private static func extractStatusCode(from line: String) -> Int {
        let pattern = #"Status Code: (\d{3})"#
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: line, range: NSRange(line.startIndex..., in: line)),
              let range = Range(match.range(at: 1), in: line),
              let code = Int(line[range]) else {
            return 0
        }
        return code
    }
}
