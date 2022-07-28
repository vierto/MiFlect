//
//  ContentView.swift
//  MiFlect
//
//  Created by Vendly on 25/07/22.
//

import SwiftUI
import CoreData

struct HomeReflection: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var searchText = ""
    @StateObject var vm = CoreDataViewModel()
    @State private var goToEditReflection = false
    
    var dataFromAddNewGoals: ReflectionEntity?
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                if vm.savedRefEntities.isEmpty {

                    Text("Reflection Not found!")

                } else {
                    
                    ForEach(vm.savedRefEntities) { entity in
                        
                        VStack(alignment: .leading, spacing: 20) {
                            
                            VStack(alignment: .leading, spacing: 20) {
                                HStack(spacing: 24) {
                                    Text(entity.reflectionType ?? "CODING")
                                    .fontWeight(.semibold)
                                    .font(.caption)
                                    .tracking(0.36)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color(red: 0.90, green: 0.89, blue: 1))
                                    .cornerRadius(106)

                                    Text("July 21, 2022")
                                    .font(.caption)
                                    .multilineTextAlignment(.trailing)
                                    .frame(maxWidth: .infinity, alignment: .topTrailing)
                                }
                                .frame(width: 310)

                                VStack(alignment: .leading, spacing: 12) {
                                    Text(entity.reflectionTitle ?? "Improving UI Kit Skills")
                                            .fontWeight(.semibold)
                                            .font(.title3)
                                            .frame(maxWidth: .infinity, alignment: .topLeading)

                                    Text(entity.reflectionDesc ?? "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...")
                                            .font(.subheadline)
                                            .frame(maxWidth: .infinity, alignment: .topLeading)
                                            .lineSpacing(5)
                                }
                                .frame(width: 310)
                            }
                            
                            HStack(spacing: 12) {
                                    ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(red: 0.75, green: 0.73, blue: 1))
                                            .offset(x: 0, y: -2.50)
                                            .frame(width: 265, height: 12)

                                            RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(red: 0.34, green: 0.28, blue: 1))
                                            .offset(x: -87.50, y: -2)
                                            .frame(width: 90, height: 12)
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: 12.50)

                                    Text("40%")
                                    .fontWeight(.semibold)
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding(20)
                        .frame(width: 350, height: 230)
                        .background(Color(red: 238/255, green: 238/255, blue: 238/255))
                        .cornerRadius(16)
                        
                    }
                    
                }
                
                NavigationLink(destination: EditReflection(vm: vm, isEditReflectionAction: $goToEditReflection), isActive: $goToEditReflection) {
                    EmptyView()
                }
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Text("Reflection")
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            self.goToEditReflection = true
                        }, label: {
                            Image(systemName: "plus")
                                .resizable()
                                .padding(6)
                                .frame(width: 32, height: 32)
                                .foregroundColor(Color.black)
                        })
                    }
                }
                
            }
            
        }
            
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeReflection().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
