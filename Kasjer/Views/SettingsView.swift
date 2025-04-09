//
//  SettingsView.swift
//  Kasjer
//
//  Created by Jan Antonowicz on 11/08/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State var textFieldPrice: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 30) {
                Image(systemName: "xmark.app.fill")
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.system(size: 50))
                    .foregroundColor(.green)
                    .onTapGesture {
                        vm.reset()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                
                ScrollView() {
                    VStack(spacing: 20){
                        VStack(alignment: .leading) {
                            Text("Minimal value to keep in cashbox:  \(vm.limit.asCurrencyWith2Decimals())")
                                .font(.headline)
                            Text("Set new minimal value:")
                                .minimumScaleFactor(0.5)
                            TextField("Nowa wartość", text: $textFieldPrice)
                                .font(.headline)
                                .padding(.leading)
                                .frame(height: 50)
                                .background(
                                    Color.green
                                        .opacity(0.5)
                                )
                                .cornerRadius(10)
                                .keyboardType(.numberPad)
                            Button {
                                vm.limit = Double(textFieldPrice) ?? 500
                            } label: {
                                Text("Save")
                                    .font(.headline)
                                    .foregroundColor(Color.black)
                                    .frame(height: 50)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                        }
                        VStack {
                            Label("USER MANUAL", systemImage: "questionmark.circle.fill")
                                .foregroundStyle(Color.blue)
                            TipView()
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .padding(.top)

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
    }
}
