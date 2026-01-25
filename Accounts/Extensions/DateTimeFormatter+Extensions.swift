//
//  DateTimeFormatter+Extensions.swift
//  Accounts
//
//  Created by Martin Hrbáček on 25.01.2026.
//

import Foundation

extension String {
    func formattedDateTime() -> String {
        
        if let date = try? Date(self, strategy: Date.ISO8601FormatStyle(includingFractionalSeconds: true)) {
            return date.formatted(date: .abbreviated, time: .shortened)
        }
        
        if let date = try? Date(self, strategy: Date.ISO8601FormatStyle()) {
            return date.formatted(date: .abbreviated, time: .shortened)
        }
        
        // Workaround for API returning ISO8601 without timezone
        if let date = try? Date(self + "Z", strategy: Date.ISO8601FormatStyle()) {
            return date.formatted(date: .abbreviated, time: .shortened)
        }
        
        return self
    }
}
