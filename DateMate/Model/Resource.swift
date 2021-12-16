//
//  Resource.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/16.
//

import Foundation

enum Resource<T> {
    case Success(data: T)
    case Error(message: String, data: T? = nil)
    case Loading(data: T? = nil)
}
