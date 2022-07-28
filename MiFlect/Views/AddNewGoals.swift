//
//  AddNewGoals.swift
//  MiFlect
//
//  Created by Vendly on 26/07/22.
//

import SwiftUI
import CoreData

struct AddNewGoals: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State private var goalsTxtField: String = ""
    @State private var showAlert: Bool = false
    @State private var progress = 0.0

    init() {
        calculateProgress()
    }
    
    var body: some View {
        
        if vm.savedGoalEntities.isEmpty {

            Text("Reflection Goals Not found!")

        } else {
            
            VStack(alignment: .leading, spacing: 20) {
                    
                TextField("Input your reflection goals here...", text: $goalsTxtField)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .frame(height: 55)
                    .foregroundColor(Color(red: 42/255, green: 40/255, blue: 74/255))
                    .background(Color(red: 225/255, green: 225/255, blue: 225/255))
                    .cornerRadius(10)
                    
                Button(action: {
                    
                    if textFieldValidation() {
                        
                        guard !goalsTxtField.isEmpty else { return }
                        vm.addDataGoals(refGoals: goalsTxtField, isChecked: false)
                        goalsTxtField = ""
                        calculateProgress()
                    }
                            
                }, label: {
                    
                    Text("Save")
                        .fontWeight(.semibold)
                        .font(.callout)
                        .lineSpacing(24)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .frame(width: 66, height: 35)
                        .background(Color(red: 0.83, green: 0.81, blue: 1))
                        .foregroundColor(Color(red: 56/255, green: 55/255, blue: 69/255))
                        .cornerRadius(10)
                    
                })
                
                List {
                    ForEach(vm.savedGoalEntities) { entity in
                        
                        HStack {
                            Text(entity.reflectionGoals ?? "No Goals!")
                            
                            Spacer()
                            
                            if entity.checked {
                                Image(systemName: "checkmark.circle")
                                    .scaleEffect(1.3)
                                    .foregroundColor(Color(red: 86/255, green: 71/255, blue: 255/255))
                            } else {
                                Image(systemName: "circle")
                                    .scaleEffect(1.3)
                                    .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                            }
                            
                        }
                        .onTapGesture {
                            withAnimation(.linear) {
                                
                                vm.updateData(entity: entity)
                                calculateProgress()
                                
                            }
                        }
                        
                    }
                    .onDelete { (indexSet) in
                        vm.deleteGoalsData(indexSet: indexSet)
                        calculateProgress()
                    }
                    .onMove(perform: vm.moveData)
                }
                .listStyle(PlainListStyle())
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                .foregroundColor(Color.black)

                Text("Reflection Progress")
                    .font(.system(size: 24, weight: .semibold))
                
                VStack {
                    
                    HStack {
                        ProgressView(value: progress)
                        Text("\(String(format: "%.0f%%", progress * 100))")
                    }
                    
                }
                .progressViewStyle(customProgressView())
                
            }
            .padding(14)
            .navigationTitle("Add New Goals 📝")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Input must be at least 5 character long"),
                    dismissButton: .default(Text("Close"))
                )
            }
            
        }
        
    }
    
    func calculateProgress() {
        
        var checkCounter = 0.0
        
        //rumus ngitung progess bar = totalChecked / list.length

        for entity in vm.savedGoalEntities {
            
            if entity.checked { checkCounter += 1 }
            
        }
        
        progress = checkCounter / Double(vm.savedGoalEntities.count)
        
    }
    
    func textFieldValidation() -> Bool {
        if goalsTxtField.count < 5 {
            showAlert = true
            return false
        }
        return true
    }
    
}

struct customProgressView: ProgressViewStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        
        ProgressView(configuration)
            .tint(Color(red: 86/255, green: 71/255, blue: 255/255))
            .shadow(color: Color(red: 86/255, green: 71/255, blue: 255/255),
                    radius: 0.5)
        
    }
    
}

struct AddNewGoals_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddNewGoals()
        }
    }
}
