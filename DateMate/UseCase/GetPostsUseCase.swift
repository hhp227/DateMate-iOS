//
//  GetPostsUseCase.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/18.
//

import Foundation
import Combine

protocol GetPostsUseCase {
    func execute() -> AnyPublisher<Resource<[Post]>, Error>
}

final class GetPostsUseCaseImpl : GetPostsUseCase {
    private let repository: LoungeRepository
    
    func execute() -> AnyPublisher<Resource<[Post]>, Error> {
        return repository.getPosts().tryMap { post -> Resource<[Post]> in
            do {
                return Resource.success(data: post)
            } catch {
                return Resource.error(message: error.localizedDescription)
            }
        }.eraseToAnyPublisher()
    }
    
    init(_ repository: LoungeRepository) {
        self.repository = repository
    }
}
