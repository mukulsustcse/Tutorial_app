//
//  RectangleCard_button.swift
//  LearningApp
//
//  Created by M. A. Alim Mukul on 14.09.22.
//

import SwiftUI

struct RectangleCard_button: View {
    
    var color = Color.white
    
    var body: some View {
        
        Rectangle()
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct RectangleCard_button_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard_button()
    }
}
