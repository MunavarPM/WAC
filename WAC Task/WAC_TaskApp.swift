//
//  WAC_TaskApp.swift
//  WAC Task
//
//  Created by MUNAVAR PM on 16/03/24.
//

import SwiftUI

@main
struct WAC_TaskApp: App {
    @StateObject private var datacontroller = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, datacontroller.container.viewContext)
        }
    }
}
