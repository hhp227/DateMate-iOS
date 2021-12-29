//
//  WriteViewModel.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/14.
//

import Foundation

class WriteViewModel: ObservableObject {
    @Published var title: String = ""
    
    @Published var content: String = ""
    
    private let repository: WriteRepository
    
    init(_ repository: WriteRepository) {
        self.repository = repository
    }
    
    func actionSend() {
        repository.addPost(title, content)
    }
}
