//
//  SummaryLabelView.swift
//  Kasjer
//
//  Created by Jan Antonowicz on 09/04/2025.
//

import SwiftUI

struct SummaryLabelView: View {
    
    var title: String
    var ammount: Double
    var backgroundColor: Color? = .green
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text("\(ammount.asCurrencyWith2Decimals())")
                .fontWeight(.black)
                .font(.title2)
        }
        .padding()
        .background(backgroundColor)
        .withSafeDataModifier()
    }
}

#Preview {
    SummaryLabelView(title: "Minimal cashbox value:", ammount: 20.0, backgroundColor: .blue)
}
