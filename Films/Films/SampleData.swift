//
//  SampleData.swift
//  Films
//
//  Created by Artem on 8/5/24.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    let modelContainer: ModelContainer
    static let shared = SampleData()
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    private init(){
        let schema = Schema([
            Movie.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            self.insertSampleData()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    func insertSampleData(){
        for movie in Movie.sampleData {
            context.insert(movie)
        }
        do{
            try context.save()
        } catch {
            print("Sample data context failed to save.")
        }
       
    }
    
    var movie: Movie {
        Movie.sampleData[0]
    }
}
