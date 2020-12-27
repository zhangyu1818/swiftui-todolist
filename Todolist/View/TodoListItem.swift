//
//  TodoListItem.swift
//  Todolist
//
//  Created by ZhangYu on 2020/12/25.
//

import SwiftUI

struct TodoListItem: View {
    @EnvironmentObject var todolistModelData: TodoViewModel

    @State private var title: String
    @State private var showInfoIcon: Bool = true
    @State private var showTodoDetalModal = false

    @Binding private var isEditing: Bool

    let todoItem: Todo

    init(todoItem: Todo, isEditing: Binding<Bool>) {
        self.todoItem = todoItem
        _isEditing = isEditing
        _title = State(initialValue: todoItem.title)
    }

    var body: some View {
        HStack(spacing: 8) {
            let iconName = todoItem.completed ? "largecircle.fill.circle" : "circle"
            let iconColor = todoItem.completed ? Color.blue : Color.secondary

            let textColor = todoItem.completed ? Color.secondary : Color.primary

            Image(systemName: iconName).foregroundColor(iconColor)
                .font(.title2).offset(y: -3).onTapGesture {
                    withAnimation {
                        changeValue(completed: !todoItem.completed)
                    }
                }
            VStack {
                HStack {
                    TextField("", text: $title) { isEditing in
                        self.isEditing = isEditing
                        if isEditing {
                            showInfoIcon = false
                        } else {
                            changeValue(title: title)
                            showInfoIcon = true
                        }
                    }.foregroundColor(textColor)
                    if showInfoIcon {
                        Button(action: {
                            showTodoDetalModal = true
                        }) {
                            Image(systemName: "info.circle").font(.title2).padding(.trailing)
                        }
                        .sheet(isPresented: $showTodoDetalModal) {
                            TodoDetailView(showModal: $showTodoDetalModal, currentTodo: todoItem)
                        }
                    }
                }
                Divider()
            }
        }.padding(.top, 6)
    }

    func changeValue(title: String? = nil, completed: Bool? = nil) {
        todolistModelData.replaceContainsTodo(todoItem.clone(title: title, completed: completed))
    }
}

struct TodoListItem_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TodoListItem(todoItem: Todo(userId: 1, id: 1, title: "新待办事项", completed: false), isEditing: .constant(false))
            TodoListItem(todoItem: Todo(userId: 1, id: 1, title: "新待办事项", completed: true), isEditing: .constant(false))
        }.previewLayout(.fixed(width: 350, height: 100))
    }
}
