//
//  ContentView.swift
//  Todolist
//
//  Created by ZhangYu on 2020/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ListView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(TodoViewModel())
    }
}
