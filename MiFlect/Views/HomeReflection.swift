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

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    @State private var goToEditReflection = false
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                
                ForEach(0..<10) { index in
                    
                    VStack(alignment: .leading, spacing: 20) {
                        
                        VStack(alignment: .leading, spacing: 20) {
                            HStack(spacing: 24) {
                                Text("CODING")
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
                                        Text("Improving UI Kit Skills")
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                        .frame(maxWidth: .infinity, alignment: .topLeading)

                                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...")
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
                
                NavigationLink(destination: EditReflection(), isActive: $goToEditReflection) {
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

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
