//
//  ContentModel.swift
//  LearningApp
//
//  Created by M. A. Alim Mukul on 10.09.22.
//

import Foundation

class ContentModel: ObservableObject {
    
    // List of modules
    @Published var modules = [Module]()
    
    // Current module
    @Published var currentModule : Module?
    var currentModuleIndex = 0
    
    var styleData: Data?
    
    init() {
        
        getLocalData()
    }
    
    // MARK: Data JSON parsing
    
    func getLocalData() {
        
        
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
//            print(error)
            print("Cannot parse local data")
        }
        
        // parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            
            // Read the file into a data object
            let styleData = try Data(contentsOf: styleUrl!)
            
            self.styleData = styleData
            
            
        } catch {
//            print(error)
            print("Cannot parse style data")
        }
        
        
        
    }
    
    // MARK: Module navigation methods
    
    func beginModule(_ moduleid:Int) {
        
        // find the index for this module id
        for index in 0..<modules.count {
            
            if modules[index].id == moduleid {
             
                // found the matching module
                currentModuleIndex = index
                break
            }
        }
        
        // set the current module
        currentModule = modules[currentModuleIndex]
    }
}
