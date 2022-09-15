//
//  TestView.swift
//  LearningApp
//
//  Created by M. A. Alim Mukul on 14.09.22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    @State var selectedAnswerIndex:Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack(alignment: .leading) {
                
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                
                // question
                CodeTextView()
                    .padding(.horizontal, 20)
                
                // answer
                ScrollView {
                    
                    VStack {
                        
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) {
                            
                            index in
                            
                            Button(action: {
                                
                                // track the selected index
                                selectedAnswerIndex = index
                                
                                
                            }, label: {
                            
                                
                                ZStack {
                                    
                                    if submitted == false {
                                    
                                        RectangleCard_button(color: index == selectedAnswerIndex ? .gray : .white)
                                            .frame(height: 48)
                                    }
                                    else {
                                        
                                        // answer has been submitted
                                        if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex {
                                            
                                            // user has selected the right answer
                                            // show a green background
                                            RectangleCard_button(color: Color.green)
                                                .frame(height: 48)
                                        }
                                        else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                            
                                            // user has selected the wrong answer
                                            // show a red background
                                            RectangleCard_button(color: Color.red)
                                                .frame(height: 48)
                                        }
                                        else if index == model.currentQuestion!.correctIndex {
                                            
                                            // this button is the correct answer
                                            // show a green background
                                            RectangleCard_button(color: Color.green)
                                                .frame(height: 48)
                                        }
                                        else {
                                            RectangleCard_button(color: Color.white)
                                                .frame(height: 48)
                                        }
                                    }
                                    
                                    Text(model.currentQuestion!.answers[index])
                                }
                                
                            })
                            .disabled(submitted)
                            
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
                // button
                
                Button(action: {
                    
                    // change the submitted state to true
                    submitted = true
                    
                    // check the answer and incremenet the counter if correct
                    if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                        
                        numCorrect += 1
                    }
                    
                }, label: {
                    
                    ZStack {
                        
                        RectangleCard_button(color: .green)
                            .frame(height: 48)
                        
                        Text("Submit")
                            .bold()
                            .foregroundColor(.white)
                            
                    }
                    .padding()
                })
                .disabled(selectedAnswerIndex == nil)
                
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
