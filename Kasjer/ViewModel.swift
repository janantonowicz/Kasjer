//
//  ViewModel.swift
//  Kasjer
//
//  Created by Woturios on 11/08/2022.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var plusMinus: Bool = false
    @Published var selectedNominal: Double = 0
    @Published var sum: Double = 0
    @Published var safe: Double = 500
    @Published var minusSafe: Double = 0
    
    let values: [Double] = [
        500, 200, 100, 50, 20, 10, 5, 2, 1, 0.5, 0.2, 0.1, 0.05, 0.02, 0.01,
    ]
        
    let change: [Int] = [
        10, 5, 2, 1
    ]
        
    @Published var array: [ItemModel] = []
    @Published var safeArray: [ItemModel] = []
    @Published var putToSafe: [ItemModel] = []
        
    func sumItems() {
        sum = array.sum(\.theValue)
    }
    
    func updateArray() {
        safeArray = array.filter({ $0.nominal > 4 }).sorted(by: { $0.nominal > $1.nominal }).filter({ $0.count > 0 })
        minusSafe = sum
//        print("safeArray = array.filter, minusSafe = sum")
        while minusSafe > safe {
//            print("minusSafe > safe")
            if minusSafe - (safeArray.first?.nominal ?? 0) >= safe {
//                print("minusSafe - first >= safe")
                if safeArray.first?.count ?? 0 > 0 {
//                    print("safeArray.first.count > 0")
                    if let firstItem = safeArray.first {
                        safeArray.append(ItemModel(nominal: firstItem.nominal, count: firstItem.count - 1, id: firstItem.id, theValue: firstItem.theValue))
                        minusSafe = minusSafe - firstItem.nominal
                        safeArray.removeFirst()
//                        print("REMOVE FIRST")
                        safeArray = safeArray.filter({ $0.nominal > 4 }).sorted(by: { $0.nominal > $1.nominal }).filter({ $0.count > 0 })
                    }
                } else {
                    return
                }
            } else {
                safeArray.remove(at: 0)
                safeArray = safeArray.filter({ $0.nominal > 4 }).sorted(by: { $0.nominal > $1.nominal }).filter({ $0.count > 0 })
            }
        }
//        putToSafe = (array.filter({ $0.nominal > 4 }).sorted(by: { $0.nominal > $1.nominal }).filter({ $0.count > 0 }) - safeArray)
    }
}

