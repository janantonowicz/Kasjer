//
//  KasjerApp.swift
//  Kasjer
//
//  Created by Woturios on 10/08/2022.
//

import SwiftUI

@main
struct KasjerApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(ViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
