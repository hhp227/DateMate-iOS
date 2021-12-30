//
//  RegisterViewModel.swift
//  DateMate
//
//  Created by 홍희표 on 2021/11/28.
//

import Foundation
import Firebase

class SignUpViewModel: ObservableObject {
    let repository: UserRepository
    
    func signUp(email: String, password: String) {
        repository.signUp(email: email, password: password)
    }
    
    init(_ repository: UserRepository) {
        self.repository = repository
    }
}
