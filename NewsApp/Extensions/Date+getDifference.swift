//
//  Date+getDifference.swift
//  NewsApp
//
//  Created by Samar Ali on 1/8/22.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit

extension Date {

    static func getDifference (endDate: Date, startDate: Date) -> Int {
        return Int(endDate.timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate)
    }
    
}
