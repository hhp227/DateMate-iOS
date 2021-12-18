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
    
    private let getPostUseCase: GetPostsUseCase
    
    private var subscription = Set<AnyCancellable>()
    
    private func getPosts() {
        getPostUseCase.execute().receive(on: DispatchQueue.main).sink(receiveCompletion: onReceive, receiveValue: onReceive).store(in: &subscription)
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
    
    func onReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure:
            break
        }
    }
    
    func test() {
    }
    
    init(_ getPostUseCase: GetPostsUseCase) {
        self.getPostUseCase = getPostUseCase
        
        getPosts()
    }
    
    struct State {
        var isLoading = false
        
        var posts = [Post]()
        
        var error = ""
        
    }
}
