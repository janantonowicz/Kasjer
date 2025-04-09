//
//  SafeView.swift
//  Kasjer
//
//  Created by Jan Antonowicz on 12/08/2022.
//

import SwiftUI

struct SafeView: View {
    
    @EnvironmentObject private var vm: ViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var cashbox: [RecordModel] = []
    @State var safebox: [RecordModel] = []
    
    var body: some View {
            VStack(spacing: 5) {
                Image(systemName: "xmark.app.fill")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.system(size: 50))
                    .foregroundColor(.orange)
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .padding(.horizontal)
                
                
                ScrollView {
                    VStack(spacing: 10) {
                        SummaryLabelView(
                            title: "Minimal cashbox value:",
                            ammount: vm.limit,
                            backgroundColor: Color.blue
                        )
                        
                        SummaryLabelView(
                            title: "Whole cash:",
                            ammount: vm.sum,
                            backgroundColor: Color.green
                        )
                        
                        SummaryLabelView(
                            title: "Leave in cashbox:",
                            ammount: vm.cashboxFinal,
                            backgroundColor: Color.pink
                        )
                                                
                        ListView(array: vm.cashboxInput)
                        
                        SummaryLabelView(
                            title: "Put into the safebox:",
                            ammount: (vm.sum - vm.cashboxFinal),
                            backgroundColor: Color.cyan
                        )
                        
                        ListView(array: vm.safeInput)
                    }
                    .padding(.horizontal)
                }
            }
            .onAppear {
                vm.createSummary()
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

