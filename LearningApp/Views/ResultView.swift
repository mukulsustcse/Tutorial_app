//
//  ResultView.swift
//  LearningApp
//
//  Created by M. A. Alim Mukul on 16.09.22.
//

import SwiftUI

struct ResultView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var numCorrect: Int
    
    var resultString: String {
        
        guard model.currentModule != nil else {
            return ""
        }
        
        let pct = Double(numCorrect) / Double(model.currentModule!.test.questions.count)
        
        if pct > 0.5 {
            return "Awesome!"
        }
        else if pct > 0.2 {
            return "Doing great!"
        }
        else {
            
            return "Keep learning. Wish you all the best!"
        }
    }
    
    var body: some View {
        Spacer()
        
        VStack {
            
            Text(resultString)
                .font(.title)
            Spacer()
            
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) question")
            Spacer()
            
            Button(action: {
                
                // send the user back to the home view
                model.currentTestSelected = nil
                
            }, label: {
                
                ZStack {
                    
                    RectangleCard_button(color: .green)
                        .frame(height: 48)
                    
                    Text("Complete")
                        .bold()
                        .foregroundColor(.white)
                }
                .padding()
            })
            Spacer()
        }
    }
}

//struct ResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultView()
//    }
//}
