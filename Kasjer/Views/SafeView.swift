//
//  SafeView.swift
//  Kasjer
//
//  Created by Woturios on 12/08/2022.
//

import SwiftUI

struct SafeView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Image(systemName: "xmark")
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
                }
            Text("Minimalna wartość kasetki:  \(vm.limit.asCurrencyWith2Decimals())")
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
            
            Text("Wszystkie pieniądze w kasetce: \(vm.sum.asCurrencyWith2Decimals())")
            
            Text("W kasetce zostanie: \(vm.kasetka.asCurrencyWith2Decimals())")
            Text("Do sejfu schowaj: \((vm.sum - vm.kasetka).asCurrencyWith2Decimals())")
            
            VStack{
                ForEach(vm.safeInput) { item in
                    Text("\(item.nominal), \(item.count)")
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            vm.calculateSafe()
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
