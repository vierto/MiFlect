//
//  CoreDataVM.swift
//  MiFlect
//
//  Created by Vendly on 26/07/22.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [ReflectionEntity] = []
    
    init() {
        
        container = NSPersistentContainer(name: "ReflectionContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
        
        fetchData()
        
    }
    
    func fetchData() {
        
        let request = NSFetchRequest<ReflectionEntity>(entityName: "ReflectionEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching. \(error)")
        }
        
    }
    
    func addData(text: String) {
        
        let newReflection = ReflectionEntity(context: container.viewContext)
        newReflection.title = text
        saveData()
        
    }
 
//    func updateData(entity: ReflectionEntity) {
//
//        let currTitle = entity.title ?? ""
//        let newTitle = currTitle + "!"
//        entity.title = newTitle
//        saveData()
//
//    }
    
    func deleteData(indexSet: IndexSet) {
        
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        saveData()
        
    }
    
    func saveData() {
        
        do {
            try container.viewContext.save()
            fetchData()
        } catch let error {
            print("Error saving. \(error)")
        }
        
    }
    
}

