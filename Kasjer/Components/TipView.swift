//
//  TipView.swift
//  Kasjer
//
//  Created by Jan Antonowicz on 09/04/2025.
//

import SwiftUI

struct TipView: View {
    var body: some View {
            Text("""
                     1. Select nominal by tapping the rectangle with ammount.
                     
                     2. Add quantity by pressing rounded buttons. The numbers will be added to sum.
                                                  
                     3. Change between adding and subtracting by toggling +/- button. Press the clear button to reset the ammount.
                     
                     4. Use 'apply' button to save the entry and use sum button to see the summary.
                     
                     5. Reset with red button in left top corner.
                     """)
            .font(.callout)
            .opacity(0.6)
            .multilineTextAlignment(.leading)
            .padding()
        
    }
}

#Preview {
    TipView()
}
