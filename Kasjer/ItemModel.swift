//
//  ItemModel.swift
//  Kasjer
//
//  Created by Woturios on 10/08/2022.
//

import Foundation
import SwiftUI

struct ItemModel: Identifiable {
    var nominal: Double
    var count: Int
//    let color: Color
    let id: UUID
    let theValue: Double
}
