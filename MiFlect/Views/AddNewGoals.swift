//
//  AddNewGoals.swift
//  MiFlect
//
//  Created by Vendly on 26/07/22.
//

import SwiftUI
import CoreData

struct AddNewGoals: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm = CoreDataViewModel()
    @State var goalsTxtField: String = ""
    @State var showAlert: Bool = false
    @State private var progress = 0.25
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading, spacing: 20) {

                TextField("Input your reflection goals here...", text: $goalsTxtField)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .frame(height: 55)
                    .background(Color(red: 225/255, green: 225/255, blue: 225/255))
                    .cornerRadius(10)

                Button(action: {
                    
                    if textFieldValidation() {
                        guard !goalsTxtField.isEmpty else { return }
                        vm.addData(text: goalsTxtField)
                        goalsTxtField = ""
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
                    ForEach(vm.savedEntities) { entity in
                        Text(entity.title ?? "No Title!")
//                            .onTapGesture {
//                                vm.updateData(entity: entity)
//                            }
                    }
                    .onDelete(perform: vm.deleteData)
                }
                .listStyle(DefaultListStyle())
                
                VStack {
                    ProgressView(value: progress)
                    Button("More", action: { progress += 0.05 })
                }
                .progressViewStyle(DarkBlueShadowProgressViewStyle())
                
            }
            .padding(14)
            .navigationTitle("Add New Goals 📝")
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Input must be at least 5 character long"),
                    dismissButton: .default(Text("Close"))
//                    message: Text("Input your destinated Phone Number and tap Save button"),
                )
            }
//            .alert(
//                alertTitle, isPresented: $showAlert, presenting: details
//            ) { detail in
//                Button(role: .destructive) {
//                    // Handle delete action.
//                } label: {
//                    Text("""
//                            Delete \(detail.name)
//                            """)
//                }
//                Button("Retry") {
//                    // handle retry action.
//                }
//            } message: { detail in
//                Text(detail.error)
//            }
            
        }
        
    }
    
    func textFieldValidation() -> Bool {
        if goalsTxtField.count < 5 {
            showAlert = true
            return false
        }
        return true
    }
    
}

struct DarkBlueShadowProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ProgressView(configuration)
            .shadow(color: Color(red: 0, green: 0, blue: 0.6),
                    radius: 4.0, x: 1.0, y: 2.0)
    }
}

struct AddNewGoals_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGoals()
    }
}
