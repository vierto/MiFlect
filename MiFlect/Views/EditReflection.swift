//
//  EditReflection.swift
//  MiFlect
//
//  Created by Vendly on 26/07/22.
//

import SwiftUI

struct EditReflection: View {
    
    @StateObject var vm = CoreDataViewModel()
    @State private var goToAddNewGoals: Bool = false
    @State private var titleTxtField: String = ""
    @State private var typeTxtField: String = ""
    @State private var descTxtField: String = ""
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .center, spacing: 14) {
                
                ZStack {
                    
                    if titleTxtField.isEmpty {
                        Text("Write title here...")
                        .font(.system(size: 30, weight: .semibold))
                        .foregroundColor(Color(red: 153/255, green: 153/255, blue: 153/255))
                        .frame(width: 310, alignment: .topLeading)
                    }
                    
                    TextField("", text: $titleTxtField)
                        .font(.system(size: 30, weight: .semibold))
                        .frame(width: 310, alignment: .topLeading)
                    
                }
                
                HStack {
                    
                    ZStack {
                        
                        if typeTxtField.isEmpty {
                            Text("Input type here...")
                                .font(.system(size: 12, weight: .semibold))
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .foregroundColor(Color(red: 86/255, green: 71/255, blue: 255/255).opacity(0.6))
                                .background(Color(red: 0.90, green: 0.89, blue: 1))
                                .cornerRadius(100)
                                .frame(width: .infinity, height: 20, alignment: .leading)
                        }
                        
                        TextField("", text: $typeTxtField)
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(Color(red: 86/255, green: 71/255, blue: 255/255))
                            .frame(width: .infinity, height: 20, alignment: .leading)
                        
                    }

                    Text("July 21, 2022")
                    .fontWeight(.medium)
                    .font(.callout)
                    .foregroundColor(Color(red: 83/255, green: 81/255, blue: 100/255))
                    .frame(width: 110, height: 20, alignment: .top)
                    
                }
                    
                NavigationLink(destination: AddNewGoals(), isActive: $goToAddNewGoals) {
                    EmptyView()
                }
                
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 0.83, green: 0.81, blue: 1))
                    .frame(width: 350, height: 510)

                    if descTxtField.isEmpty {
                        Text("Write your reflection here...")
                            .font(.callout)
                            .foregroundColor(Color(red: 34/255, green: 34/255, blue: 46/255).opacity(0.6))
                            .frame(width: 315, height: 474.30, alignment: .topLeading)
                            .lineSpacing(24)
                    }

                    TextField("", text: $descTxtField)
                        .font(.callout)
                        .frame(width: 315, height: 474.30, alignment: .topLeading)
                }
                .frame(width: 350, height: 510)

                HStack(alignment: .top, spacing: 10) {

                    Button(action: {

                        self.goToAddNewGoals = true

                    }, label: {

                        Text("Goals")
                        .fontWeight(.semibold)
                        .font(.callout)
                        .lineSpacing(24)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .frame(width: 170)
                        .background(Color(red: 0.83, green: 0.81, blue: 1))
                        .foregroundColor(Color(red: 56/255, green: 55/255, blue: 69/255))
                        .cornerRadius(10)

                    })

                    Button(action: {

                        guard !titleTxtField.isEmpty else { return }
                        guard !typeTxtField.isEmpty else { return }
                        guard !descTxtField.isEmpty else { return }
                        
                        vm.addDataReflection(refTitle: titleTxtField, refType: typeTxtField, refDesc: descTxtField)
                        
                        titleTxtField = ""
                        typeTxtField = ""
                        descTxtField = ""
                        
                    }, label: {
                        
                        Text("Save")
                        .fontWeight(.semibold)
                        .font(.callout)
                        .lineSpacing(24)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .frame(width: 170)
                        .background(Color(red: 0.83, green: 0.81, blue: 1))
                        .foregroundColor(Color(red: 56/255, green: 55/255, blue: 69/255))
                        .cornerRadius(10)
                        
                    })
                }
            }
            .navigationBarTitle("Edit Reflection", displayMode: .inline)
            
        }
        
    }
    
}

struct EditReflection_Previews: PreviewProvider {
    static var previews: some View {
        EditReflection()
    }
}
