//
//  ContentModel.swift
//  LearningApp
//
//  Created by M. A. Alim Mukul on 10.09.22.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    var styleData: Data?
    
    init() {
        
        getlocalData()
    }
    
    func getlocalData() {
        
        
        // get a url to the json file
        let jsonurl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            // read the file into a data object
            let jsonData = try Data(contentsOf: jsonurl!)
            
            let jsonDecoder = JSONDecoder()
            let modules = try  jsonDecoder.decode([Module].self, from: jsonData)
            
            // assign parsed modules to modules property
            self.modules = modules
            
        } catch {
            print(error)
            print("Cannot parse local data")
        }
        
        // parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            
            // read the file into a data object
            let style_data = try Data(contentsOf: styleUrl!)
            
            self.styleData = style_data
            
        } catch {
            print(error)
            print("Cannot parse style data")
        }
        
        
        
    }
}
