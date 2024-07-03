//
//  Date+Ext.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-07-03.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}
