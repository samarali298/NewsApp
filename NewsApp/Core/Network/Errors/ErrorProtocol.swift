//
//  ErrorProtocols.swift
//  NewsApp
//
//  Created by Samar Ali on 1/6/22.
//  Copyright (c) 2022 All rights reserved.
//

import Foundation

protocol ErrorProtocol: Codable, Error {
    var message: String? { get set }
    var status: String? { get set }
    var code: String? { get set }
}
