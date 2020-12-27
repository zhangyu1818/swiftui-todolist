//
//  FetchTodolist.swift
//  Todolist
//
//  Created by ZhangYu on 2020/12/24.
//

import Alamofire
import Foundation

func fetchTodoList(onSuccess: @escaping ([Todo]) -> Void) {
    AF.request("https://jsonplaceholder.typicode.com/todos").responseDecodable(of: [Todo].self) { res in
        guard let value = res.value else {
            print("fetch error")
            return
        }
        onSuccess(value)
    }
}
