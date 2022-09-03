//
//  DateExtenstion.swift
//  Waste2x
//
//  Created by MAC on 04/06/2021.
//  Copyright © 2021 Haider Awan. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    var startOfMonth: Date {

        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)

        return  calendar.date(from: components)!
    }

    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var endOfMonth: Date {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }

    func isMonday() -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday == 2
    }
    
    
    func dateToString(_ stringFormatter : String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = stringFormatter
        let dateString = formatter.string(from: self)
        let date = formatter.date(from: dateString)
        formatter.dateFormat = stringFormatter
        let returnString = formatter.string(from: date ?? self)

        return returnString
    }
}
