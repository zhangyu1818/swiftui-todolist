//
//  TodoDetailView.swift
//  Todolist
//
//  Created by ZhangYu on 2020/12/26.
//

import SwiftUI

struct TodoDetailView: View {
    @EnvironmentObject private var todolistModelData: TodoViewModel

    @Binding private var showModal: Bool

    @State private var title = "新待办事项"
    @State private var remark = ""
    @State private var URL = ""

    private var currentTodo: Todo?

    init(showModal: Binding<Bool>, currentTodo: Todo? = nil) {
        _showModal = showModal
        if let todo = currentTodo {
            self.currentTodo = todo
            _title = State(initialValue: todo.title)
            _remark = State(initialValue: todo.remark ?? "")
            _URL = State(initialValue: todo.URL ?? "")
        }
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("标题", text: $title)
                TextField("备注", text: $remark)
                TextField("URL", text: $URL)
            }
            .navigationBarTitle(Text("详细信息"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("取消", action: {
                        showModal = false
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("完成", action: {
                        showModal = false
                        guard let todo = currentTodo else {
                            let templateTodo = Todo.createTemplateTodo()
                            todolistModelData.addTodo(templateTodo.clone(title: title, completed: false, remark: remark, URL: URL))
                            return
                        }
                        todolistModelData.replaceContainsTodo(todo.clone(title: title, completed: false, remark: remark, URL: URL))
                    })
                }
            }
        }
    }
}

struct TodoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TodoDetailView(showModal: .constant(false))
    }
}
