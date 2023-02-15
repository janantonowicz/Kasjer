//
//  SettingsView.swift
//  Kasjer
//
//  Created by Woturios on 11/08/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @State var textFieldPrice: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Image(systemName: "xmark.app.fill")
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 50))
                    .foregroundColor(.red)
                    .onTapGesture {
                        vm.reset()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                Spacer()
            }
            .padding(.top)

            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Obecny limit kasetki:  \(vm.limit.asCurrencyWith2Decimals())")
                        .font(.headline)
                }
                Text("Ustaw nową wartość dla kasetki")
                    .frame(height: 55)
                    .font(.title)
                    .minimumScaleFactor(0.5)
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 60)
                        .foregroundColor(.red.opacity(0.8))
                    
                    TextField("Nowa wartość", text: $textFieldPrice)
                        .font(.headline)
                        .padding(.leading)
                        .frame(height: 55)
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(3)
                        .keyboardType(.numberPad)
                }
                Button {
                    vm.limit = Double(textFieldPrice) ?? 500
                } label: {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(Color.black)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }

            }
            .padding()
            .padding(.top, 100)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(ViewModel())
            .preferredColorScheme(.dark)
    }
}
