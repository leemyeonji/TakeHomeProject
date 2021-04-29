//
//  Date+Extension.swift
//  GithubFollowers
//
//  Created by 임현지 on 2021/04/29.
//

import Foundation

//string -> Date -> string
extension Date {
    func converToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy, MMM d"
        return dateFormatter.string(from: self)
    }
}
