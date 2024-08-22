//
//  GridItem+Ext.swift
//  GithubFollowersSwiftUI
//
//  Created by Jonathan Ricky Sandjaja on 22/08/24.
//

import SwiftUI

extension GridItem {
    func makeThreeColumn() -> [GridItem] {
        return Array.init(repeating: GridItem(.flexible(), spacing: 20), count: 3)
    }
}
