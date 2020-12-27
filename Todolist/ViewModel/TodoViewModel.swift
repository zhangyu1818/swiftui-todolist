//
//  TodoViewModel.swift
//  Todolist
//
//  Created by ZhangYu on 2020/12/24.
//

import Combine
import Foundation

final class TodoViewModel: ObservableObject {
    @Published var todolist = [Todo]()
    @Published var fetching = false

    var completed: [Todo] { filterTodolist(isCompleted: true) }

    var notCompleted: [Todo] { filterTodolist(isCompleted: false) }

    var sortedTodolist: [Todo] { todolist.sorted(by: { !$0.completed && $1.completed }) }

    private func filterTodolist(isCompleted: Bool) -> [Todo] {
        return todolist.filter { $0.completed == isCompleted }
    }

    func fetchTodolist() {
        fetching = true
        fetchTodoList { value in
            self.todolist = value
            self.fetching = false
        }
    }

    func clear() {
        todolist.removeAll()
    }

    func replaceContainsTodo(_ newValue: Todo) {
        guard let index = todolist.firstIndex(where: { $0.id == newValue.id }) else { return }
        todolist[index] = newValue
    }

    func addTodo(_ todo: Todo) {
        todolist.append(todo)
    }
}
