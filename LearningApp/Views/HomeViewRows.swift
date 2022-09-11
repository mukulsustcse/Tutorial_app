//
//  HomeViewRows.swift
//  LearningApp
//
//  Created by M. A. Alim Mukul on 10.09.22.
//

import SwiftUI

struct HomeViewRows: View {
    
    var image:String
    var title:String
    var description:String
    var lessonString: String
    var time: String
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            
            HStack {
                
                // Image
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                
                Spacer()
                
                // Text
                VStack (alignment: .leading, spacing: 10) {
                    
                    // Headline
                    Text(title)
                        .bold()
                    
                    // Description
                    Text(description)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 20)
                        .font(.caption)
                    
                    HStack {
                        
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        
                        Text(lessonString)
                            .font(.system(size: 10))
                        
                        Spacer()
                        
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        
                        Text(time)
                            .font(.system(size: 10))
                        
                    }
                }
                .padding(.leading, 20)
            }
            .padding(.horizontal, 20.0)
            
        }
    }
}

struct HomeViewRows_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRows(image: "swift", title: "Learn Swift", description: "demo description data", lessonString: "20 Lessons", time: "20 Hours")
    }
}
