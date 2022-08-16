//
//  SafeView.swift
//  Kasjer
//
//  Created by Woturios on 12/08/2022.
//

import SwiftUI

struct SafeView: View {
    
    @EnvironmentObject private var vm: ViewModel
    
    var body: some View {
        VStack {
            Text("Minimalna wartość kasetki:  \(vm.safe.asCurrencyWith2Decimals())")
            
            Text("W kasetce zostanie: \(vm.minusSafe)")
            
            Text("Wszystkie pieniądze w kasetce: \(vm.sum)")
            
        }
        .onAppear {
            vm.updateArray()
        }
    }
}

struct SafeView_Previews: PreviewProvider {
    static var previews: some View {
        SafeView()
            .environmentObject(ViewModel())
    }
}
