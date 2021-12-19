//
//  SignInUseCase.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/19.
//

import Foundation
import Combine
import FirebaseAuth

protocol SignInUseCase {
    func execute(email: String, password: String) -> AnyPublisher<Resource<AuthDataResult>, Error>
}

class SignInUseCaseImpl: SignInUseCase {
    let repository: UserRepository
    
    func execute(email: String, password: String) -> AnyPublisher<Resource<AuthDataResult>, Error> {
        return repository.signIn(email: email, password: password).tryMap { result in
            do {
                return Resource.success(data: result)
            } catch {
                return Resource.error(message: error.localizedDescription)
            }
        }.eraseToAnyPublisher()
    }
    
    init(_ repository: UserRepository) {
        self.repository = repository
    }
}
