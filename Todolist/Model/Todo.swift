//
//  Todo.swift
//  Todolist
//
//  Created by ZhangYu on 2020/12/24.
//

import Foundation

struct Todo: Equatable, Hashable, Codable, Identifiable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
    var remark: String? = ""
    var URL: String? = ""

    func clone(title: String? = nil, completed: Bool? = nil, remark: String? = "", URL: String? = "") -> Todo {
        return Todo(userId: userId, id: id, title: title ?? self.title, completed: completed ?? self.completed, remark: remark, URL: URL)
    }

    static func createTemplateTodo() -> Todo {
        return Todo(userId: UUID().hashValue, id: UUID().hashValue, title: "", completed: false)
    }
}
