//
//  LoungeViewModel.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/07.
//

import Foundation
import Combine

class LoungeViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    private let repository: LoungeRepository
    
    private var subscription = Set<AnyCancellable>()
    
    init(_ repository: LoungeRepository) {
        self.repository = repository
    }
    
    func test() {
        print("LoungeViewModel test \(repository.test())")
    }
    
    func getPosts() {
        repository.getPosts().sink(receiveCompletion: onReceive, receiveValue: onReceive).store(in: &subscription)
    }
    
    func onReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure:
            break
        }
    }
    
    private func onReceive(_ batch: [Post]) {
        self.posts = batch
    }
}
