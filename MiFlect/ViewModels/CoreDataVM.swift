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
    @Published var savedRefEntities: [ReflectionEntity] = []
    @Published var savedGoalEntities: [GoalEntity] = []
    
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
        
        let reflectionRequest = NSFetchRequest<ReflectionEntity>(entityName: "ReflectionEntity")
        let goalRequest = NSFetchRequest<GoalEntity>(entityName: "GoalEntity")
        
        do {
            savedRefEntities = try container.viewContext.fetch(reflectionRequest)
            savedGoalEntities = try container.viewContext.fetch(goalRequest)
        } catch let error {
            print("Error fetching. \(error)")
        }
        
    }
    
    func addDataGoals(refGoals: String, isChecked: Bool) {
        
        let newReflection = GoalEntity(context: container.viewContext)
        newReflection.reflectionGoals = refGoals
        newReflection.checked = isChecked
        saveData()
        
    }
    
    func addDataReflection(refTitle: String, refType: String, refDesc: String) {
        
        let newReflection = ReflectionEntity(context: container.viewContext)
        newReflection.reflectionTitle = refTitle
        newReflection.reflectionType = refType
        newReflection.reflectionDesc = refDesc
        saveData()
        
    }
    
    func deleteData(indexSet: IndexSet) {
        
        guard let index = indexSet.first else { return }
        let entity = savedRefEntities[index]
        container.viewContext.delete(entity)
        saveData()
        
    }
    
    func moveData(indexSet: IndexSet, destination: Int) {
        savedRefEntities.move(fromOffsets: indexSet, toOffset: destination)
    }
    
    func updateData(entity: GoalEntity, totalEntity: [GoalEntity], isChecked: Bool) {
        
        if let idx = totalEntity.firstIndex(where: { $0.reflectionGoals == entity.reflectionGoals }) {

            entities[idx].checked = isChecked

            saveData()
        }
        
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

