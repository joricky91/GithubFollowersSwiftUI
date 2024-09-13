//
//  Date+Ext.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 04/09/24.
//

import Foundation

extension Date {
    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
}
