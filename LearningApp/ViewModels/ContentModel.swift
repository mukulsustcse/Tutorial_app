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
    
    // Current lesson
    @Published var currentLesson : Lesson?
    var currentLessonIndex = 0
    
    // Current questions
    @Published var currentQuestion:Question?
    var currentQuestionIndex = 0
    
    // current lesson explanation
    @Published var codeText = NSAttributedString()
    
    var styleData: Data?
    
    // current selected content and test
    @Published var currentContentSelected:Int?
    @Published var currentTestSelected:Int?
    
    init() {
        
        // parse local json data
        getLocalData()
        
        // download remote json file and parse data
        getRemoteData()
    }
    
    // MARK: local JSON parsing
    
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
    
    // MARK: remote JSON parsing
    
    func getRemoteData() {
        
        // https://mukulsustcse.github.io/Tutorial_app_data/data2.json
        
        // string path
        
        let urlString = "https://mukulsustcse.github.io/Tutorial_app_data/data2.json"
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            
            // cannot create url
            return
        }
        
        // create a URL Request object
        let request = URLRequest(url: url!)
        
        // get the session and kick off the task
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            // check if there is an error
            guard error == nil else {
                
                // there was an error
                return
            }
            
            do {
                // create json decoder
                let decoder = JSONDecoder()
                
                // decode
                let modules = try decoder.decode([Module].self, from: data!)
                
                // append parsed modules into modules property
                self.modules += modules
            }
            catch {
                
                print(error)
            }
            
            // handle the response
            
        }
        
        // kick off data task
        dataTask.resume()
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
    
    func beginLesson( _ lessonIndex:Int) {
        
        // check that the lesson index is within range of module lessons
        
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }
        else {
            currentLessonIndex = 0
        }
        
        // set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson() {
        
        // advance the lesson
        currentLessonIndex += 1
        
        // check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            // set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            
            codeText = addStyling(currentLesson!.explanation)
        }
        else {
            // reset the lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func hasNextLesson() -> Bool {
        
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
        
        // Lengthy way to do it
        //        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
        //            return true
        //        }
        //        else {
        //            return false
        //        }
    }
    
    func beginTest(_ moduleID:Int) {
        
        // set the current module
        beginModule(moduleID)
        
        // set the current question
        currentQuestionIndex = 0
        
        // if there are questions, set the current question to the first one
        
        if currentModule?.test.questions.count ?? 0 > 0 {
            
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            
            // set the question content
            codeText = addStyling(currentQuestion!.content)
        }
    }
    
    func nextQuestion() {
        
        // advance the question index
        currentQuestionIndex += 1
        
        // check that's it's within the range of questions
        if currentQuestionIndex < currentModule!.test.questions.count {
            
            // set the current question
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }

        // if not, reset the properties
        else {
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
    
    // MARK: Code styling
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // add the styling data
        if styleData != nil {
            
            data.append(self.styleData!)
        }
        
        // add the html data
        data.append(Data(htmlString.utf8))
        
        // convert to attributed string
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            resultString = attributedString
        }
        
        return resultString
    }
}
