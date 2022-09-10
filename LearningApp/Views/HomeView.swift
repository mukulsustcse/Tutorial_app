//
//  ContentView.swift
//  LearningApp
//
//  Created by M. A. Alim Mukul on 10.09.22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        Text("Hello, world!")
            .padding()
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

