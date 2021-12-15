//
//  PostDetailViewModel.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/14.
//

import Foundation

class PostDetailViewModel: ObservableObject {
    private let repository: PostDetailRepository
    
    init(_ repository: PostDetailRepository) {
        self.repository = repository
    }
}
