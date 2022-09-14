//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by M. A. Alim Mukul on 11.09.22.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {

            if url != nil {
                
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            // MARK: Description
            CodeTextView()
            
            // show next lesson button, only if there is a next lesson
            
            if model.hasNextLesson() {
                
                // MARK: Next lesson button
                Button(action: {
                    // go to the next lesson
                    model.nextLesson()
                    
                }, label: {
                    ZStack {
                        
                        RectangleCard_button(color: Color.green)
                            .frame(height: 48)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex+1].title)")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                })
            }
            
            else {
                // show the complete button instead
                
                Button(action: {
                    
                    // Take the user back to the home view
                    model.currentContentSelected = nil
                    
                }, label: {
                    ZStack {
                        
                        RectangleCard_button(color: Color.red)
                            .frame(height: 48)
                        
                        Text("Complete")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                })
            }
        }
        .padding()
        .navigationBarTitle(lesson?.title ?? "")
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
