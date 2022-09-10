//
//  LearningAppApp.swift
//  LearningApp
//
//  Created by M. A. Alim Mukul on 10.09.22.
//

import SwiftUI

@main
struct LearningApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
