//
//  UserRepository.swift
//  DateMate
//
//  Created by 홍희표 on 2021/12/01.
//

import Foundation
import FirebaseAuth

class UserRepository {
    let auth = Auth.auth()
    
    var user: User?
    
    func signIn(email: String, password: String, result: @escaping (SignInState) -> Void) {
        result(SignInState.Loading)
        auth.signIn(withEmail: email, password: password) { authDataResult, error in
            if authDataResult != nil {
                result(SignInState.Success)
            } else if error != nil {
                result(SignInState.Failure)
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
    }
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { authDataResult, error in
            guard authDataResult != nil, error == nil else {
                return
            }
        }
    }
    
    func getCurrentUser() -> User? {
        return auth.currentUser
    }
}

enum SignInState {
    case Success
    case Loading
    case Failure
}
