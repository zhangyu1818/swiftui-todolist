//
//  TodolistApp.swift
//  Todolist
//
//  Created by ZhangYu on 2020/12/24.
//

import SwiftUI

@main
struct TodolistApp: App {
    @StateObject private var todolistModelData = TodoViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(todolistModelData)
        }
    }
}
