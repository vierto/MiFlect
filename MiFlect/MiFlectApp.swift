//
//  MiFlectApp.swift
//  MiFlect
//
//  Created by Vendly on 25/07/22.
//

import SwiftUI

@main
struct MiFlectApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeReflection()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
