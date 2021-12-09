//
//  LoungeViewModel.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/07.
//

import Foundation

class LoungeViewModel: ObservableObject {
    private let repository: LoungeRepository
    
    init(_ repository: LoungeRepository) {
        self.repository = repository
    }
    
    func test() {
        print("LoungeViewModel test \(repository.test())")
    }
    
    func test2() {
        repository.get()
    }
}
