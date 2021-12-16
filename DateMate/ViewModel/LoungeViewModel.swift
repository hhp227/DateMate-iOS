//
//  LoungeViewModel.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/07.
//

import Foundation
import Combine

class LoungeViewModel: ObservableObject {
    @Published var state = State()
    
    private let repository: LoungeRepository
    
    private var subscription = Set<AnyCancellable>()
    
    private func getPosts() {
        repository.getPosts().tryMap(postUseCase).receive(on: DispatchQueue.main).sink(receiveCompletion: onReceive, receiveValue: onReceive).store(in: &subscription)
    }
    
    private func onReceive(_ result: Resource<[Post]>) {
        switch result.state {
        case .Success:
            self.state = State(posts: result.data ?? [Post]())
        case .Error:
            self.state = State(error: result.message ?? "An unexpected error occured")
        case .Loading:
            self.state = State(isLoading: true)
        }
    }
    
    private func postUseCase(_ batch: [Post]) -> Resource<[Post]> {
        do {
            return Resource.success(data: batch)
        } catch {
            return Resource.error(message: error.localizedDescription)
        }
    }
    
    func onReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure:
            break
        }
    }
    
    func test() {
        print("LoungeViewModel test \(repository.test())")
    }
    
    init(_ repository: LoungeRepository) {
        self.repository = repository
        
        getPosts()
    }
    
    struct State {
        var isLoading = false
        
        var posts = [Post]()
        
        var error = ""
        
    }
}
