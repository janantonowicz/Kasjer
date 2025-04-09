//
//  ListView.swift
//  Kasjer
//
//  Created by Jan Antonowicz on 12/03/2025.
//

/// This is generic view for displaying nominals and quantity list
/// will be used in main view user input summary and also in Safe View both for 'put to safe' and 'leave in cashbox lists'

import SwiftUI

struct ListView: View {

    var array: [RecordModel]
    
    var borderColor: Color = Color.primary.opacity(0.7)
    var rowColor: Color = Color.gray.opacity(0.7)
    var headerColor: Color = Color.gray.opacity(0.2)
    
    var body: some View {
        // header
        VStack(spacing: 0) {
            HStack {
                Text("Nominal:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.footnote.weight(.bold))
                Text("Count:")
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .font(.footnote.weight(.bold))
            }
            .padding()
            .background(headerColor)
                        
            VStack(spacing: 0) {
                ForEach(array.indices, id: \.self) { index in
                    let item = array[index]
                    if item.count > 0 {
                        HStack {
                            Text(item.nominal.asCurrencyWith2Decimals())
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("\(item.count)")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .padding(.horizontal)
                        .frame(height: 40, alignment: .center)
                        .background(index % 2 == 0 ? rowColor : rowColor.opacity(0.2))
                    }
                }
            }
        }
        .cornerRadius(10)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let array: [RecordModel] = [
            RecordModel(nominal: 100, count: 10),
            RecordModel(nominal: 50, count: 6),
            RecordModel(nominal: 20, count: 1),
            RecordModel(nominal: 100, count: 10),
            RecordModel(nominal: 50, count: 6),
            RecordModel(nominal: 20, count: 1)
        ]
        
        ListView(array: array)
            .padding(40)
            .preferredColorScheme(.dark)
    }
}
