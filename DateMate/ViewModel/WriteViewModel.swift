//
//  WriteViewModel.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/14.
//

import Foundation
import Combine
import FirebaseDatabase

class WriteViewModel: ObservableObject {
    @Published var title: String = ""
    
    @Published var content: String = ""
    
    @Published var state = State()
    
    private let repository: WriteRepository
    
    private var subscription = Set<AnyCancellable>()
    
    func onReceive(_ result: DatabaseReference) {
        print("onReceive: \(result)")
    }
    
    func onReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            state.success.toggle()
            break
        case .failure:
            break
        }
    }
    
    func actionSend() {
        guard !title.isEmpty, !content.isEmpty else {
            return
        }
        repository.addPost(title, content).sink(receiveCompletion: onReceive, receiveValue: onReceive).store(in: &subscription)
    }
    
    init(_ repository: WriteRepository) {
        self.repository = repository
    }
    
    deinit {
        subscription.removeAll()
    }
    
    struct State {
        var success: Bool
        
        init(_ success: Bool = false) {
            self.success = success
        }
    }
}

enum WriteEvent {
    case OnDoneChange(post: Post, isDone: Bool)
}
