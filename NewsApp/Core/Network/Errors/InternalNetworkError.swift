//
//  InternalNetworkError.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

class InternalNetworkError: ErrorProtocol, Codable {
    var message: String?
    var status: String?
    var code: String?
}

public enum Errors: Swift.Error {    
    case keyNotExist
}
