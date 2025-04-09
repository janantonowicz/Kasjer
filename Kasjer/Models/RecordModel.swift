//
//  ItemModel.swift
//  Kasjer
//
//  Created by Woturios on 10/08/2022.
//

import Foundation
import SwiftUI

/// Model for current calculation data
/// Every
struct RecordModel: Identifiable {
    var nominal: Double
    var count: Double
//    let color: Color
    let id: UUID
    let theValue: Double
}
