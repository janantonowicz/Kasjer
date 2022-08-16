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
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
            
            Text("Wszystkie pieniądze w kasetce: \(vm.sum.asCurrencyWith2Decimals())")
            
            Text("W kasetce zostanie: \(vm.minusSafe.asCurrencyWith2Decimals())")
            Text("Do sejfu schowaj: \((vm.sum - vm.minusSafe).asCurrencyWith2Decimals())")
            
        }
        .padding(.horizontal)
        .onAppear {
            vm.updateArray()
        }
    }
}

struct SafeView_Previews: PreviewProvider {
    static var previews: some View {
        SafeView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
    }
}
