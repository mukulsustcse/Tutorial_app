//
//  TestView.swift
//  LearningApp
//
//  Created by M. A. Alim Mukul on 14.09.22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        
        
        if model.currentQuestion != nil {
            
            VStack {
                
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                
                // question
                CodeTextView()
                
                // answer
                
                // button
            }
            .navigationTitle("\((model.currentModule?.category) ?? "") Test")
        }
        else {
            
            // Test hasn't loadead yet
            // iOS 14.5+ bug solve
            ProgressView()
        }
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
