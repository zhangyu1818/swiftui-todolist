//
//  HomeView.swift
//  Todolist
//
//  Created by ZhangYu on 2020/12/25.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject private var todolistModelData: TodoViewModel

    @State private var showCompleted = false
    @State private var isEditing = false

    @State private var showDeleteAlert = false
    @State private var showTodoDetailModal = false

    @ViewBuilder
    private func renderList() -> some View {
        let renderList = showCompleted ? todolistModelData.sortedTodolist : todolistModelData.notCompleted
        if todolistModelData.fetching {
            ProgressView()
        } else if renderList.isEmpty {
            Text("没有待办事项").foregroundColor(.secondary)
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(renderList) { item in
                        TodoListItem(todoItem: item, isEditing: $isEditing)
                    }
                    .transition(.slide)
                }.padding()
            }
        }
    }

    var body: some View {
        NavigationView {
            renderList()
                .navigationTitle("待办事项")
                .toolbar {
                    ToolbarItem(placement: .primaryAction) {
                        if isEditing {
                            Button("完成", action: {
                                self.hideKeyboard()
                            })
                        } else {
                            Menu(content: {
                                Button(action: todolistModelData.fetchTodolist) {
                                    Label("请求模拟数据", systemImage: "icloud.and.arrow.down").foregroundColor(.blue)
                                }
                                Button(action: {
                                    withAnimation {
                                        showCompleted.toggle()
                                    }
                                }) {
                                    Label("\(showCompleted ? "隐藏" : "显示")已完成项目", systemImage: showCompleted ? "eye.slash" : "eye")
                                }
                                Button(action: {
                                    showDeleteAlert = true
                                }) {
                                    Label("删除列表", systemImage: "trash")
                                }
                            }) {
                                Label("More", systemImage: "ellipsis.circle").font(.title3)
                            }
                        }
                    }

                    ToolbarItemGroup(placement: .bottomBar) {
                        Button(action: {
                            showTodoDetailModal = true
                        }) {
                            Image(systemName: "plus.circle.fill").font(.title2)
                            Text("新待办事项").bold()
                        }.sheet(isPresented: $showTodoDetailModal) {
                            TodoDetailView(showModal: $showTodoDetailModal)
                        }
                        Spacer()
                    }
                }.alert(isPresented: $showDeleteAlert) {
                    Alert(title: Text("删除\"待办事项\"？"), message: Text("这将删除此列表中的所有待办事项"), primaryButton: .destructive(Text("删除").foregroundColor(.red)) {
                        todolistModelData.clear()
                    }, secondaryButton: .cancel(Text("取消")))
                }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().environmentObject(TodoViewModel())
    }
}

#if canImport(UIKit)
    extension View {
        func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
#endif
