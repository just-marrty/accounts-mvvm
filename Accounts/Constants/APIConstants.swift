//
//  APIConstants.swift
//  Accounts
//
//  Created by Martin Hrbáček on 25.01.2026.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://webapi.developers.erstegroup.com/api/csas/public/sandbox/v3"
    static let endpoints = "/transparentAccounts"
}

enum API {
    static let baseURL = "https://webapi.developers.erstegroup.com/api/csas/public/sandbox/v3"
    
    enum Endpoints {
        static let transparentAccounts = "/transparentAccounts"
    }
    
    enum Header {
        static let webApiKey = "web-api-key"
    }
}
