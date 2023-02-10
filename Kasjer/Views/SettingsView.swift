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
    
    var body: some View {
        VStack {
            Text("Ustaw nową wartość dla kasetki")
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 60)
                
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
                    .background(Color.white)
                    .cornerRadius(10)
            }

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
