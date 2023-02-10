//
//  ViewModel.swift
//  Kasjer
//
//  Created by Woturios on 11/08/2022.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published var plusMinus: Bool = false
    @Published var selectedNominal: Double = 0.0
    @Published var sum: Double = 0.0
    @Published var limit: Double = 500.0
    @Published var kasetka: Double = 0.0
    
    let values: [Double] = [
        500, 200, 100, 50, 20, 10, 5, 2, 1, 0.5, 0.2, 0.1, 0.05, 0.02, 0.01,
    ]
        
    let change: [Int] = [
        10, 5, 2, 1
    ]
        
    @Published var array: [ItemModel] = []
    @Published var safeInput: [ItemModel] = []
    
    // Pom values
    var pomNominal = 0.0
    var pomCount = 0.0
        
    func sumItems() {
        sum = array.sum(\.theValue)
    }
    
    func calculateSafe() {
        array = array.sorted(by: { $0.nominal > $1.nominal})
        array.forEach { item in
            pomNominal = item.nominal
            pomCount = item.count
            
            calculateForNominal()
            
            pomCount = 0.0
            pomNominal = 0.0
        }
    }
    
    func calculateForNominal() {
        if ((sum - (pomNominal*pomCount)) > limit) {
             sum = (sum - (pomNominal*pomCount))
            guard pomCount > 0 else { return }
            safeInput.append(ItemModel(
                nominal: pomNominal,
                count: pomCount,
                id: UUID(),
                theValue: pomCount*pomNominal))
            return
        } else {
            guard pomCount > 0 else { return }
            pomCount = (pomCount-1)
            calculateForNominal()
        }
    }
}

