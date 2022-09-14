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
        
        NavigationView {
            
            VStack(alignment: .leading) {
                
                Text("What do you want to do today?")
                    .padding(.leading, 20)
                
                ScrollView {
                    
                    LazyVStack {
                        
                        ForEach(model.modules) { module in
                            
                            VStack(spacing: 20) {
                                
                                NavigationLink(tag: module.id,
                                               selection: $model.currentContentSelected,
                                               destination: {
                                    ContentView()
                                        .onAppear(perform: {
                                            model.beginModule(module.id)
                                        })
                                },
                                               label: {
                                    // learning card
                                    HomeViewRows(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, lessonString: String(module.content.lessons.count) + " Lessons", time: module.content.time)
                                })
                                
//                                NavigationLink(tag: module.id,
//                                               selection: model.currentLessonIndex,
//
//                                               destination: {
//
//                                    ContentView()
//                                        .onAppear(perform: {
//                                            model.beginModule(module.id)
//                                        })
//
//                                }, label: {
//
//                                    // learning card
//                                    HomeViewRows(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, lessonString: String(module.content.lessons.count) + " Lessons", time: module.content.time)
//
//                                })
                                
                                
                                
                                // test card
                                HomeViewRows(image: module.test.image, title: "\(module.category) Test", description: module.test.description, lessonString: "\(module.test.questions.count) Lessons", time: module.test.time)
                            }
                        }
                    }
                    .accentColor(.black)
                    .padding(.all)
                }
            }
            .navigationTitle("Get Started")
        }
        // x code 13 update
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}

