//
//  MyWidgetApp.swift
//  MyWidget
//
//  Created by Cedric Fourneau on 14/11/2023.
//

import SwiftUI

@main
struct MyWidgetApp: App {
    var network = Network()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}

