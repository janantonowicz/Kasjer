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
            Text("Minimalna wartość kasetki:  \(vm.safe.asCurrencyWith2Decimals())")
                .font(.headline)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
            
            Text("Wszystkie pieniądze w kasetce: \(vm.sum.asCurrencyWith2Decimals())")
            
            Text("W kasetce zostanie: \(vm.minusSafe.asCurrencyWith2Decimals())")
            Text("Do sejfu schowaj: \((vm.sum - vm.minusSafe).asCurrencyWith2Decimals())")
            
            Text("Safe array:")
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(vm.safeArray) { item in
                        ZStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(height: 55)
                                
                                HStack(spacing: 0) {
                                    Text(item.nominal.asCurrencyWith2Decimals())
                                        .font(.title)
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Text("\(item.theValue.asCurrencyWith2Decimals())")
                                        .font(.headline)
                                }
                                .foregroundColor(Color.white)
                                .padding(.horizontal)
                            }
                            
                            ZStack {
                                Circle()
                                    .frame(height: 65)
                                    .foregroundColor(Color.black)
                                
                                Text("\(item.count)")
                                    .font(.title)
                                    .foregroundColor(Color.white)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                        .foregroundColor(item.count < 0 ? Color.red.opacity(0.3) : Color.blue.opacity(0.2))
                        .cornerRadius(10)
                    }
                }
                Rectangle()
                    .frame(height: 70)
                    .opacity(0.0001)
            }
            .frame(maxHeight: UIScreen.main.bounds.height - 600)
            
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
