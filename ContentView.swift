//
//  ContentView.swift
//  Vogue Vista
//
//  Created by SMD Thiranjaya on BE 2567-03-14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            StartupPageViewController()
                .navigationBarHidden(true) // Hide navigation bar if you don't want it
        }
    }
}
